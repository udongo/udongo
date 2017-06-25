class ContentPictureDecorator < ApplicationDecorator
  delegate_all

  def max_image_size
    (1600.0 / 12.0 * column.width_xl.to_f).to_i
  end
end
