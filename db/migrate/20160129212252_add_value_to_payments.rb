class AddValueToPayments < ActiveRecord::Migration
  def change
    change_table :payments do |t|
      t.integer :value, default: 0
    end
  end
end
