require 'rails_helper'

RSpec.describe Loan, type: :model do
  describe "outstanding_balance" do

    let(:loan) {
      loan = Loan.create!(funded_amount: 100.0)
      # Payment can't be created with their own let, would never run because of lazy evaluation
      Payment.create!(date: 1.day.ago, amount: 15, loan: loan)
      Payment.create!(date: Date.today, amount: 10, loan: loan)
      loan
    }

    it "returns the proper amount" do
      expect(loan.outstanding_balance).to eq 75.0
    end
  end
end
