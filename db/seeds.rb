loan = Loan.create!(funded_amount: 100.0, start_date: 6.months.ago, monthly_payment: 10.0, apr: 5.0)
Payment.create!(date: 5.months.ago, amount: 15.0, loan: loan)
Payment.create!(date: 3.months.ago, amount: 20.0, loan: loan)
