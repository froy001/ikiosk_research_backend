describe 'Sign Up API' do
  context 'when unregistered user signs up' do
    let(:sign_up) { sign_up_with_api(email, pass, pass_confirmation) }
    before(:each) do
      sign_up
    end
    context 'invalid credentials' do
      context 'when invalid email format' do
        let(:email) { "froy001" }
        let(:pass) { '12345678' }
        let(:pass_confirmation) { pass }

        it 'response with error and code 403' do
          expect(response).not_to be_success
          expect(json['status']).to eq('error')
          expect(response.status).to eq(403)
        end

        it 'has errors with email field' do
          expect(json['errors']).not_to be_blank
          expect(json['errors'].to_json).to have_json_path("email")
          expect(json['errors']['email']).not_to be_blank
        end

        it 'has 1 error: email: is not an email' do
          expect(json['errors'].to_json).to have_json_size(1).at_path("email")
          expect(json['errors']['email'][0]).to eq("is not an email")
        end
      end

      context 'with pass != pass_confirmation' do
        let(:email) { "froy001@gmail.com" }
        let(:pass) { '12345678' }
        let(:pass_confirmation) { '1' }

         it 'response with error and code 403' do
          expect(response).not_to be_success
          expect(json['status']).to eq('error')
          expect(response.status).to eq(403)
        end

        it 'has errors with password_confirmation field' do
          expect(json['errors']).not_to be_blank
          expect(json['errors'].to_json).to have_json_path("password_confirmation")
          expect(json['errors']['password_confirmation']).not_to be_blank
        end

        it 'has 1 error: password_confirmation: is not an password_confirmation' do
          expect(json['errors'].to_json).to have_json_size(1).at_path("password_confirmation")
          expect(json['errors']['password_confirmation'][0]).to eq("doesn't match Password")
        end
      end

      context 'with to short password' do
        let(:email) { "froy001@gmail.com" }
        let(:pass) { '1234' }
        let(:pass_confirmation) { '1234' }

         it 'response with error and code 403' do
          expect(response).not_to be_success
          expect(json['status']).to eq('error')
          expect(response.status).to eq(403)
        end

        it 'has errors with password field' do
          expect(json['errors']).not_to be_blank
          expect(json['errors'].to_json).to have_json_path("password")
          expect(json['errors']['password']).not_to be_blank
        end

        it 'has 1 error: password: is not an password' do
          expect(json['errors'].to_json).to have_json_size(1).at_path("password")
          expect(json['errors']['password'][0]).to eq("is too short (minimum is 8 characters)")
        end
      end

      context 'user already registered' do
        let(:email) { "froy001@gmail.com" }
        let(:pass) { '12345678' }
        let(:pass_confirmation) { pass }
        let(:other_pass) { 'abcdefgh'}

        it 'response with error and code 403' do
          sign_up_with_api(email, other_pass, other_pass)
          expect(response).not_to be_success
          expect(json['status']).to eq('error')
          expect(response.status).to eq(403)
        end

        it 'returns errors with email field' do
          sign_up_with_api(email, other_pass, other_pass)
          expect(json['errors']).not_to be_blank
          expect(json['errors'].to_json).to have_json_path("email")
          expect(json['errors']['email']).not_to be_blank
        end

        it 'has 1 error: email: is not an email' do
          sign_up_with_api(email, other_pass, other_pass)
          expect(json['errors'].to_json).to have_json_size(1).at_path("email")
          expect(json['errors']['email'][0]).to eq("address is already in use")
        end
      end
    end

    context 'when valid credentials' do
      let(:email) { "froy001@gmail.com" }
      let(:pass) { '12345678' }
      let(:pass_confirmation) { '12345678' }

      it 'responds with success and code 200' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'returns a user json with field id not nil' do
        expect(json['data']['id']).not_to be_nil
      end

      it 'has email = uid' do
        expect(json['data']['email']).to eq(json['data']['email'])
      end
    end
  end

end
