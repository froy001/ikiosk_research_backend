describe 'Sign In Api' do
  context 'when user signs in' do
    let(:sign_in) { sign_in_with_api(email, password) }
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in
    end

    context 'with valid user' do
      let(:email) { user.email }
      let(:password) {  user.password }

      it 'it succeeds' do
        expect(response).to be_success
      end

      it 'it has status 200' do
        expect(response.status).to eq(200)
      end

      it 'returns a user json object in the body' do
        expect(response.body).to include_json(user.to_json)
      end

      it 'response incudes access-token header' do
        expect(response.headers['access-token']).not_to be_blank
      end

      it 'response includes token-type header' do
        expect(response.headers['token-type']).not_to be_blank
      end

      it 'response includes client header' do
        expect(response.headers['client']).not_to be_blank
      end

      it 'response includes uid header' do
        expect(response.headers['uid']).not_to be_blank
      end

      it 'response includes expiry header' do
        expect(response.headers['expiry']).not_to be_blank
      end
      context 'and already signed in' do
        it 'it fails' do
          sign_in_with_api(email, password)
          expect(response).not_to be_success
        end

        it 'it includes correct errors' do
          sign_in_with_api(email, password)
          expect((JSON.parse response.body)['errors']).to be_json_eql(
            [I18n.t('devise.failure.multi_sessions_forbidden')].to_json)
        end
      end

    end
      context 'with invalid email' do
        let(:email) { "invalid@gmail.com" }
        let(:password) { user.password }

        it 'it does not succeed' do
          expect(response).not_to be_success
        end

        it 'it includes an error message' do
          expect(response.body).to be_json_eql( {:errors =>
            [I18n.t('devise_token_auth.sessions.bad_credentials')] }.to_json)
        end
      end

      context 'with invalid password' do
        let(:email) { user.email }
        let(:password) {  "badbadbad*pass" }

        it 'it does not succeed' do
          expect(response).not_to be_success
        end

        it 'it includes an error message' do
          expect(response.body).to be_json_eql( {:errors =>
            [I18n.t('devise_token_auth.sessions.bad_credentials')] }.to_json)
        end
      end
  end
end
