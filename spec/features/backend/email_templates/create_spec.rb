require 'rails_helper'
require_relative '../pages/login_page'
require_relative '../pages/email_template_page'

describe 'create e-mail templates' do
  let(:login_page) { Features::Pages::LoginPage.new }
  let(:email_template_page) { Features::Pages::EmailTemplatePage.new }

  before(:each) do
    login_page.visit
    login_page.login
  end

  it 'with success' do
    visit '/backend/email_templates/new'
    email_template_page.fill_in_general 'foo', 'bar'
    email_template_page.fill_in_settings 'Foo', 'foo@bar.baz', 'cc@bar.baz', 'bcc@bar.baz'
    email_template_page.submit

    template = EmailTemplate.first
    expect(template.identifier).to eq 'foo'
    expect(template.description).to eq 'bar'
    expect(template.from_name).to eq 'Foo'
    expect(template.from_email).to eq 'foo@bar.baz'
    expect(template.cc).to eq 'cc@bar.baz'
    expect(template.bcc).to eq 'bcc@bar.baz'

    expect(page).to have_current_path("/backend/email_templates/#{template.id}/edit/nl")
    expect(page).to have_content('E-mail template werd toegevoegd.')
  end

  it 'without success' do
    visit '/backend/email_templates/new'
    email_template_page.submit

    expect(page).to have_current_path('/backend/email_templates')
    expect(page).to have_content('Er trad een fout op.')
  end
end
