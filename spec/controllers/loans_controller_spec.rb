require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  describe '#index' do
    it 'responds with a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    let(:loan) { Loan.create!(funded_amount: 100.0, start_date: 6.months.ago, monthly_payment: 10.0, apr: 5.0) }

    it 'responds with a 200' do
      get :show, id: loan.id
      expect(response).to have_http_status(:ok)
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        get :show, id: 10000
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#payments' do
    let(:loan) {
      loan = Loan.create!(funded_amount: 100.0, start_date: 6.months.ago, monthly_payment: 10.0, apr: 5.0)
      # Payment can't be created with their own let, would never run because of lazy evaluation
      Payment.create!(date: 5.months.ago, amount: 15.0, loan: loan)
      Payment.create!(date: 3.months.ago, amount: 20.0, loan: loan)
      loan
    }

    it 'responds with a 200' do
      get :payments, id: loan.id
      expect(response).to have_http_status(:ok)
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        get :payments, id: 10000
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
