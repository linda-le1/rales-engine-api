class AddMerchantstoItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :merchant, foreign_key: true
  end
end
