require 'rails_helper'

RSpec.describe Loan, type: :model do
  describe "outstanding_balance" do

    let(:loan) {
      loan = Loan.create!(funded_amount: 100.0, start_date: 6.months.ago, monthly_payment: 10.0, apr: 5.0)
      # Payment can't be created with their own let, would never run because of lazy evaluation
      Payment.create!(date: 5.months.ago, amount: 15.0, loan: loan)
      Payment.create!(date: 3.months.ago, amount: 20.0, loan: loan)
      loan
    }

    it "returns the proper amount" do
      expect(loan.outstanding_balance).to eq 65.0
    end

    it "computes the proper expected balance" do
      expect(loan.expected_balance_on(3.months.ago.to_date)).to eq 70.0
      expect(loan.expected_balance_on(1.month.ago.to_date)).to eq 50.0
    end

    it "computes the proper interests" do
      expect(loan.interests).to eq 11.85
    end

  end
end
