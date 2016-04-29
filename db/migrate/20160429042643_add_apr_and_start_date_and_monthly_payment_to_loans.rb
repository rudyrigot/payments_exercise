class AddAprAndStartDateAndMonthlyPaymentToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :apr, :float
    add_column :loans, :start_date, :date
    add_column :loans, :monthly_payment, :float
  end
end
