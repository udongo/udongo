require 'rails_helper'

describe RedirectDecorator do
  it '#respond_to?' do
    expect(build(:redirect).decorate).to respond_to(
      :status_code_collection, :summary
    )
  end
end
