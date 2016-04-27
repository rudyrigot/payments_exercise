class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.date :date
      t.float :amount
      t.references :loan, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
