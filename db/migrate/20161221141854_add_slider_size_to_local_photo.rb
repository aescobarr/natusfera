class AddSliderSizeToLocalPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :slider_url, :string
  end
end
