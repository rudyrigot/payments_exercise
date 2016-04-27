require 'rails_helper'

RSpec.describe Payment, type: :model do

  let(:loan) {
    loan = Loan.create!(funded_amount: 100.0)
    # Payment can't be created with their own let, would never run because of lazy evaluation
    Payment.create!(date: 1.day.ago, amount: 15, loan: loan)
    Payment.create!(date: Date.today, amount: 10, loan: loan)
    loan
  }

  it "cannot exceed outstanding amount" do
    new_payment = Payment.create(date: Date.today, amount: 80, loan: loan)
    expect(new_payment.errors.size).to eq 1
    expect(new_payment.errors[:amount][0]).to eq "exceeds loan's outstanding amount"
  end
end
