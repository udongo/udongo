class AddAlignmentOptionsToContentRows < ActiveRecord::Migration[5.0]
  def change
    add_column :content_rows, :full_width, :boolean, after: 'rowable_id'
    add_column :content_rows, :horizontal_alignment, :string, after: 'full_width'
    add_column :content_rows, :vertical_alignment, :string, after: 'horizontal_alignment'
  end
end
