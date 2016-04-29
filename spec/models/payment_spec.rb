require 'rails_helper'

RSpec.describe Payment, type: :model do

  let(:loan) {
    loan = Loan.create!(funded_amount: 100.0, start_date: 6.months.ago, monthly_payment: 10.0, apr: 5.0)
    # Payment can't be created with their own let, would never run because of lazy evaluation
    Payment.create!(date: 5.months.ago, amount: 15.0, loan: loan)
    Payment.create!(date: 3.months.ago, amount: 20.0, loan: loan)
    loan
  }

  it "cannot exceed outstanding amount" do
    new_payment = Payment.create(date: Date.today, amount: 80, loan: loan)
    expect(new_payment.errors.size).to eq 1
    expect(new_payment.errors[:amount][0]).to eq "exceeds loan's outstanding amount"
  end
end
