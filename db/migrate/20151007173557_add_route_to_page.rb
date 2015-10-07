class AddRouteToPage < ActiveRecord::Migration
  def change
    add_column :pages, :route, :string, after: 'locales'
  end
end
