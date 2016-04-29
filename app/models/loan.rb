class Loan < ActiveRecord::Base
  has_many :payments, -> { order(:date) }, dependent: :destroy

  validates :funded_amount, :start_date, :monthly_payment, :apr, presence: true

  def outstanding_balance
    funded_amount - Payment.where(loan: self).sum(:amount)
  end

  # Computes the maximum balance that the account is expected to carry on a given date
  # in order not to pay any interests.
  # Client is expected to pay the loan's monthly_payment every month.
  #
  # @param [Date] date the date used to check against
  # @return [Float] the expected balance
  def expected_balance_on(date)
    nb_months = ((date - self.start_date)/30).floor
    funded_amount - (nb_months * self.monthly_payment)
  end

  # Computes the interests the client must pay considering their payment history.
  # Iterates from the loan's start date to today, day by day, to compute the interests that
  # are due for each day, considering the difference with the expected balance and the APR of the loan.
  #
  # @return the total interests to date, rounded up to 2 decimals
  def interests
    # As we iterate through the dates, we'll need to keep track of the current balance, considering the payments made.
    current_balance = self.funded_amount
    # For a given date, will allow us to access payments made on that day.
    payments_by_date = self.payments.group_by(&:date)
    # We will compute interests for each given day, but ultimately, we want the sum of those daily interests.
    accumulated_interests = 0.0

    # Iterating through the dates
    self.start_date.upto(Date.today) do |date|

      # Updating the current balance considering potential payments
      if payments_by_date.has_key?(date)
        payments_by_date[date].each { |payment| current_balance -= payment.amount }
      end

      # Computing today's interests
      expected_balance = self.expected_balance_on date
      todays_interests = current_balance <= expected_balance ? 0.0 : (current_balance - expected_balance)*(self.apr/365.0)

      # Accumulating the results
      accumulated_interests += todays_interests
    end

    accumulated_interests.round(2)
  end
end
