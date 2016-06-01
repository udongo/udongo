require 'rails_helper'

describe RedirectDecorator do
  let(:instance) { build(:redirect).decorate }

  it '#status_code_collection' do
    expect(instance.status_code_collection).to eq [
                                                    ['301 (Moved Permanently)', '301'],
                                                    ['303 (See Other)', '303'],
                                                    ['307 (Temporary Redirect)', '307']
                                                  ]
  end

  it '#respond_to?' do
    expect(instance).to respond_to(:status_code_collection, :summary)
  end
end
