class FormSubmissionData < ApplicationRecord
  # By saving the form submission data as a search index, you work around
  # possible slow searches for the form submissions.
  after_save do
    next if value.blank?
    index = form_submission.search_indices.find_or_create_by!(
      locale: Udongo.config.i18n.app.default_locale,
      name: name
    )
    index.value = value
    index.save!
  end

  belongs_to :form_submission

  validates :form_submission, presence: true
end
