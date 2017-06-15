class AddContentRowMarginPaddingAndBgColor < ActiveRecord::Migration[5.0]
  def change
    add_column :content_rows, :background_color, :string, after: 'vertical_alignment'
    add_column :content_rows, :padding_top, :integer, after: 'background_color'
    add_column :content_rows, :padding_bottom, :integer, after: 'padding_top'
    add_column :content_rows, :margin_top, :integer, after: 'padding_bottom'
    add_column :content_rows, :margin_bottom, :integer, after: 'margin_top'
  end
end
