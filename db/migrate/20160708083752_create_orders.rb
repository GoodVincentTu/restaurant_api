class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :email
      t.references :table, foreign_key: true

      t.timestamps
    end
  end
end
