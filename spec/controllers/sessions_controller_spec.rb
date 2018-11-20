require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { create :user }

  describe 'GET #new' do

    it 'new session' do
      get :new
      expect(response).to render_template :new
    end

  end

  describe 'POST #create' do

    context 'with valid attributes' do

      it 'create session' do
        post :create, params: {user: { email: user.email, password: user.password }}
        expect(session[:user_id]).to eq user.id
        expect(response).to redirect_to root_path
      end

    end

    context 'with invalid attributes' do

      it 'does not create a user session' do
        post :create, params: {user: { email: user.email, password: ''}}
        expect(session[:user_id]).to be_nil
        expect(response).to render_template :new
        expect(assigns(:error)).to include "Email or password is invalid"
      end

    end

  end

  describe 'DELETE #destroy' do

    it 'destroy session' do
      post :create, params: {user: { email: user.email, password: user.password }}
      expect(session[:user_id]).to eq user.id
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to root_path
    end

  end
end