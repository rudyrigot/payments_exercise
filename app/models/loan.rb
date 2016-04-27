class Loan < ActiveRecord::Base
  has_many :payments, dependent: :destroy

  validates :funded_amount, presence: true
end
