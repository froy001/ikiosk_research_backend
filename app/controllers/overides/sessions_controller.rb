module Overides
  class SessionsController < DeviseTokenAuth::SessionsController
    before_action :validate_session_uniqueness, :only => [:create]

    protected
      def render_create_error_multi_sessions_forbidden
        render json: {
          sucess: false,
          errors: [I18n.t("devise.failure.multi_sessions_forbidden")]
        }, status: 403
      end

    private
      def validate_session_uniqueness
        user = User.find_by_email(params[:email])

        if user && user.valid_password?(params[:password])
          unless user.tokens.blank?
            render_create_error_multi_sessions_forbidden
          end
        end
      end
      def resource_params
        params.permit(devise_parameter_sanitizer.for(:sign_in))
      end
  end
end
