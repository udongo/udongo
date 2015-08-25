require 'rails_helper'

describe ShortenedUrl do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:code) { expect(build(klass, code: nil)).to_not be_valid }
      it(:url) { expect(build(klass, url: nil)).to_not be_valid }
    end
  end
end
