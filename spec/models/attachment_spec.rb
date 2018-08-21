require 'rails_helper'

describe Attachment do
  let(:klass) { described_class.to_s.underscore.to_sym }

  it_behaves_like :visible
  it_behaves_like :sortable

  it '#responds_to?' do
    expect(build(klass)).to respond_to(:asset)
  end
end
