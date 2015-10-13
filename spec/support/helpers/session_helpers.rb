module Features
  module SessionHelpers
    def sign_up_with(email, password, confirmation)
      visit new_user_registration_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', :with => confirmation
      click_button 'Sign up'
    end

    def signin(email, password)
      visit new_user_session_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Sign in'
    end

  end
end

module Requests
  module SessionHelpers
    def sign_up_with_api(email, password, confirmation)
      post '/api/v1/auth', {
                  email: email, password: password,
                  password_confirmation: confirmation,
                  confirm_success_url: '/'
                }
    end

  end

  module JsonHelpers
    def json
      JSON.parse(response.body)
    end
  end

end
