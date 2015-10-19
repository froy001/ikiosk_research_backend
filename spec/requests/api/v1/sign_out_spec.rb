describe 'Sign Out Api' do
  context 'when user signs out' do
    let(:sign_in) { sign_in_with_api(email, password) }
    let(:sign_out) { sign_out_with_api(access_token, token_type, client, uid, expiry)}
    let(:user) { FactoryGirl.create(:user) }

    context 'when not signed in' do
      let(:access_token) { "thisisnotatokenreally" }
      let(:token_type) {  "Bearer" }
      let(:client) {  "thisisnotaclient" }
      let(:uid) {  "someidthatsnotthere" }
      let(:expiry) {  2.weeks.from_now.to_ms }

      before(:each) do
        sign_out
      end
      it 'it is unsuccessful' do
        expect(response).not_to be_success
      end

      it 'response status is 404' do
        expect(response.status).to eq(404)
      end

      it 'response includes user_not_found error' do
        expect(response.body).to be_json_eql({:errors =>
          [I18n.t('devise_token_auth.sessions.user_not_found')]}.to_json)
      end
    end

    context 'when signed in' do
      let(:email) {  user.email }
      let(:password) { user.password }
      before(:each) do
        sign_in
        sign_out_with_api(response.headers['access-token'],
          response.headers['token-type'], response.headers['client'],
          response.headers['uid'], response.headers['expiry'])
      end

      it 'it is successful' do
        expect(response).to be_success
      end
    end
  end
end
