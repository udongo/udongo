require 'rails_helper'

describe Udongo::MetaInfo do
  let(:instance) { Udongo::MetaInfo.new }

  it '#respond_to?' do
    expect(instance).to respond_to(
      :keywords, :keywords=, :description, :description=, :custom, :custom=,
      :title, :title=
    )
  end
end
