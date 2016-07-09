class CreateReceipts < ActiveRecord::Migration[5.0]
  def change
    create_table :receipts do |t|
      t.references :order, foreign_key: true
      t.string :payment_method

      t.timestamps
    end
  end
end
