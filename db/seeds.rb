loan = Loan.create!(funded_amount: 100.0)
Payment.create!(date: 1.day.ago, amount: 15, loan: loan)
Payment.create!(date: Date.today, amount: 10, loan: loan)
