class Payment < ActiveRecord::Base
  belongs_to :loan

  validates :loan, :date, :amount, presence: true

  validate :cannot_exceed_outstanding_amount

  def cannot_exceed_outstanding_amount
    errors.add(:amount, "exceeds loan's outstanding amount") if self.loan.outstanding_amount < self.amount
  end
end
