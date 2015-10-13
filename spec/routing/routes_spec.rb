require "rails_helper"

describe 'routes' do
  it 'routes to /api/v1/users/:id get requests' do
    expect(:get => "/api/v1/users/:id").to route_to(
      :controller => 'api/v1/users', :action => 'show',
      :format => 'json', "id"=>":id"
      )
  end

  it 'routes to the Overides::SessionsController' do
    expect(:post => 'api/v1/auth/sign_in').to route_to(
        :controller => 'overides/sessions', :action => 'create'
      )
  end

end
