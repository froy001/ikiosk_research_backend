require 'support/helpers/session_helpers'
RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
  config.include Requests::SessionHelpers, type: :request
  config.include Requests::JsonHelpers, type: :request
  config.include JsonSpec::Helpers
end
