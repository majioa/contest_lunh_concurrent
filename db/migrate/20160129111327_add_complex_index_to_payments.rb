class AddComplexIndexToPayments < ActiveRecord::Migration
  def change
    change_table :payments do |t|
      t.index [:service_id, :line_item_id], unique: true
    end
  end
end
