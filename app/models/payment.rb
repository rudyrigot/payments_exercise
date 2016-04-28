class Payment < ActiveRecord::Base
  belongs_to :loan

  validates :loan, :date, :amount, presence: true

  validate :cannot_exceed_outstanding_balance

  def cannot_exceed_outstanding_balance
    errors.add(:amount, "exceeds loan's outstanding amount") if self.loan.outstanding_balance < self.amount
  end
end
