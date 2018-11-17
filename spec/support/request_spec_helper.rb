def sign_in(user)
  visit sign_in_path
  within('#new_user') do
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Sign in'
  end
end

def sign_up(user)
  visit sign_up_path

  within('#new_user') do
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password_confirmation
    click_button 'Sign up'
  end
end

def logout
  click_link 'Logout'
end

def attachment_path(filename = 'apples.png')
  Rails.root.join('spec', 'support', 'files', filename)
end

