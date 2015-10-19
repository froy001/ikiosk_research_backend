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

    def sign_in_with_api(email, password)
      post '/api/v1/auth/sign_in', {
                  email: email, password: password
                }
    end

    def sign_out_with_api(access_token, token_type, client, uid, expiry)
      delete '/api/v1/auth/sign_out', {
        :"access-token" => access_token,
        :"token-type" => token_type,
        :client => client,
        :uid => uid,
        :expiry => expiry
      }
    end

  end

  module JsonHelpers
    def json
      JSON.parse(response.body)
    end
  end

end
