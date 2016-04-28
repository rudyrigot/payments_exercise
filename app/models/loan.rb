class Loan < ActiveRecord::Base
  has_many :payments, -> { order(:date) }, dependent: :destroy

  validates :funded_amount, presence: true

  def outstanding_balance
    funded_amount - Payment.where(loan: self).sum(:amount)
  end
end
