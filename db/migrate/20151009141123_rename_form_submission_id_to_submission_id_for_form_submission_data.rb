class RenameFormSubmissionIdToSubmissionIdForFormSubmissionData < ActiveRecord::Migration
  def change
    rename_column :form_submission_data, :form_submission_id, :submission_id
  end
end
