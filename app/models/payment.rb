class Payment < ActiveRecord::Base
  belongs_to :loan

  validates :loan, :date, :amount, presence: true
end
