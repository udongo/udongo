require 'rails_helper'

describe ContentImage do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :content_type
end
