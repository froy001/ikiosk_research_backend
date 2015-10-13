class ApiApplicationController < ApplicationController
   include DeviseTokenAuth::Concerns::SetUserByToken

end
