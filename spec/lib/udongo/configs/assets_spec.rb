require 'rails_helper'

describe Udongo::Configs::Assets do
  let(:klass) { described_class }
  let(:instance) { klass.new }

  describe 'defaults' do
    it :image_white_list do
      expect(klass.new.image_white_list).to eq %w(gif jpeg jpg png)
    end

    it :file_white_list do
      expect(klass.new.file_white_list).to eq %w(doc docx pdf txt xls xlsx)
    end
  end

  it '#respond_to?' do
    expect(klass.new).to respond_to(
      :image_white_list, :image_white_list=, :file_white_list, :file_white_list=
    )
  end
end
