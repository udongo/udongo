require 'rails_helper'

describe RedirectDecorator do
  subject { build(:redirect).decorate }

  it '#status_code_collection' do
    expect(subject.status_code_collection).to eq [
                                                    ['301 (Moved Permanently)', '301'],
                                                    ['303 (See Other)', '303'],
                                                    ['307 (Temporary Redirect)', '307']
                                                  ]
  end

  it '#summary' do
    subject = create(:redirect, source_uri: 'foo', destination_uri: 'bar').decorate

    I18n.with_locale :nl do
      expect(subject.summary).to eq 'Van /foo naar /bar'
    end
  end

  it '#status_badge' do
    expect(subject.status_badge).to be_instance_of Udongo::Redirects::StatusBadge
  end
end
