require 'rails_helper'
require_relative 'pages/login_page'
require_relative 'pages/email_template_page'

describe 'e-mail templates' do
  let(:login_page) { Features::Pages::LoginPage.new }
  let(:email_template_page) { Features::Pages::EmailTemplatePage.new }

  before(:each) do
    login_page.visit
    login_page.login
  end

  describe 'create' do
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

  describe 'edit' do
    before(:each) do
      @template = create(
        :email_template,
        identifier: 'foo',
        description: 'bar',
        from_name: 'Patrick Swayze',
        from_email: 'patrick@swayze.com',
        cc: 'cc@swayze.com',
        bcc: 'bcc@swayze.com'
      )

      @template.translation(:nl).subject = 'Subject'
      @template.translation(:nl).plain_content = 'Plain content'
      @template.translation(:nl).html_content = 'HTML content'
      @template.save
    end

    describe 'general' do
      it 'fields are prefilled' do
        email_template_page.visit
        email_template_page.click_edit

        expect(page).to have_current_path("/backend/email_templates/#{@template.id}/edit")
        expect(find_field('Interne naam').value).to eq 'foo'
        expect(find_field('Beschrijving').value).to eq 'bar'
        expect(find_field('Naam afzender').value).to eq 'Patrick Swayze'
        expect(find_field('E-mail adres afzender').value).to eq 'patrick@swayze.com'
        expect(find_field('CC').value).to eq 'cc@swayze.com'
        expect(find_field('BCC').value).to eq 'bcc@swayze.com'
      end

      it 'with success' do
        email_template_page.visit
        email_template_page.click_edit
        email_template_page.fill_in_general('foo 2', 'bar 2')
        email_template_page.fill_in_settings('Erik Bauffman', 'erik@bauffman.bar', 'cc@bauffman.bar', 'bcc@bauffman.bar')
        email_template_page.submit

        template = EmailTemplate.first
        expect(template.identifier).to eq 'foo 2'
        expect(template.description).to eq 'bar 2'
        expect(template.from_name).to eq 'Erik Bauffman'
        expect(template.from_email).to eq 'erik@bauffman.bar'
        expect(template.cc).to eq 'cc@bauffman.bar'
        expect(template.bcc).to eq 'bcc@bauffman.bar'

        expect(page).to have_current_path("/backend/email_templates/#{template.id}/edit")
        expect(page).to have_content('E-mail template werd gewijzigd.')
      end

      it 'without success' do
        email_template_page.visit
        email_template_page.click_edit
        email_template_page.fill_in_general('', '')
        email_template_page.fill_in_settings('', '', '', '')
        email_template_page.submit

        template = EmailTemplate.first
        expect(template.identifier).to eq 'foo'
        expect(template.description).to eq 'bar'
        expect(template.from_name).to eq 'Patrick Swayze'
        expect(template.from_email).to eq 'patrick@swayze.com'
        expect(template.cc).to eq 'cc@swayze.com'
        expect(template.bcc).to eq 'bcc@swayze.com'

        expect(page).to have_current_path("/backend/email_templates/#{template.id}")
        expect(page).to have_content('Er trad een fout op.')
      end
    end

    describe 'translation' do
      it 'fields are prefilled' do
        email_template_page.visit
        email_template_page.click_edit
        page.click_link 'NL'

        expect(page).to have_current_path("/backend/email_templates/#{@template.id}/edit/nl")
        expect(find_field('Onderwerp').value).to eq 'Subject'
        expect(find_field('Tekstuele inhoud').value).to eq 'Plain content'
        expect(find_field('HTML inhoud').value).to eq 'HTML content'
      end

      it 'with success' do
        email_template_page.visit
        email_template_page.click_edit
        page.click_link 'NL'
        email_template_page.fill_in_translation('Subject 2', 'Plain content 2', 'HTML content 2')
        email_template_page.submit

        template = EmailTemplate.first
        expect(template.translation(:nl).subject).to eq 'Subject 2'
        expect(template.translation(:nl).plain_content).to eq 'Plain content 2'
        expect(template.translation(:nl).html_content).to eq 'HTML content 2'

        expect(page).to have_current_path("/backend/email_templates/#{template.id}/edit/nl")
      end

      it 'without success' do
        email_template_page.visit
        email_template_page.click_edit
        page.click_link 'NL'
        email_template_page.fill_in_translation('', '', '')
        email_template_page.submit

        template = EmailTemplate.first
        expect(template.translation(:nl).subject).to eq 'Subject'
        expect(template.translation(:nl).plain_content).to eq 'Plain content'
        expect(template.translation(:nl).html_content).to eq 'HTML content'

        expect(page).to have_current_path("/backend/email_templates/#{template.id}/edit/nl")
        expect(page).to have_content('Er trad een fout op.')
      end
    end
  end
end
