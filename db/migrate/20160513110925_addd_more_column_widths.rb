class AdddMoreColumnWidths < ActiveRecord::Migration
  def change
    rename_column :content_columns, :width, :width_md
    add_column :content_columns, :width_xs, :integer, after: 'width_md'
    add_column :content_columns, :width_sm, :integer, after: 'width_xs'
    add_column :content_columns, :width_lg, :integer, after: 'width_md'
    add_column :content_columns, :width_xl, :integer, after: 'width_lg'
  end
end
