require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do

  describe '#index' do
    it 'responds with a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }
    let (:payment_1) { Payment.create!(date: Date.today, amount: 15, loan: loan) }

    it 'responds with a 200' do
      get :show, id: payment_1.id
      expect(response).to have_http_status(:ok)
    end

    context 'if the payment is not found' do
      it 'responds with a 404' do
        get :show, id: 10000
        expect(response).to have_http_status(:not_found)
      end
    end
  end

end
