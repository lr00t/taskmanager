require 'rails_helper'

RSpec.describe 'Auth', type: :request do
  let(:user) {build(:user)}

  context 'failed sign in/sign up' do

    it 'email' do
      user.email = 'test'
      sign_up user
      expect(page).to have_css('.alert-danger', text: I18n.t('simple_form.error_notification.default_message') )
    end

    it 'password' do
      user.password = 'test'
      sign_up user
      expect(page).to have_css('.alert-danger', text: I18n.t('simple_form.error_notification.default_message') )
    end

    it 'sign up && sign in with invalid password' do
      sign_up user
      user.password = 'test'
      sign_in user
      expect(page).to have_css('.alert-danger', text: 'Email or password is invalid')
    end

  end


  it 'logout' do
    sign_up user
    sign_in user
    expect(page).to have_css('#username', text: user.email)
    find_link('Logout').click
    expect(page).to have_css('#signin')
  end

end
