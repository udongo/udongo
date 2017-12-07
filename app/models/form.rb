class Form < ApplicationRecord
  include Concerns::Translatable
  translatable_fields :summary, :toggle, :redirect_url, :success_message,
                      :code_snippet

  has_many :fields, class_name: 'FormField', dependent: :destroy
  has_many :submissions, class_name: 'FormSubmission', dependent: :destroy
  has_many :data, through: :submissions
  has_many :content_forms, dependent: :destroy

  validates :description, presence: true

  def deletable?
    content_forms.empty?
  end
end
