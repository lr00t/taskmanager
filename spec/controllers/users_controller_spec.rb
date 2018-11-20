require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #new' do

    it 'new user' do
      get :new
      expect(assigns(:user)).to be_a_new User
      expect(response).to render_template :new
    end

  end

  describe 'POST #create' do

    context 'with valid attributes' do

      it 'saves the new user in db' do
        expect {post :create, params: {user: attributes_for(:user)}}.to change(User, :count).by(1)
        expect(response).to redirect_to root_path
      end

    end

    context 'with invalid attributes' do

      it 'does not save new user' do
        expect {post :create, params: {user: attributes_for(:invalid_user)}}.to_not change(User, :count)
        expect(response).to render_template :new
      end

    end
  end
end