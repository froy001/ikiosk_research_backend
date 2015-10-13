module Api
  module V1

    class UsersController < ApiApplicationController

      before_action :authenticate_user!
      before_action :admin_only, :except => :show

      def show
        @user = User.find(params[:id])
        unless current_user.admin?
          unless @user == current_user
            redirect_to :back, :alert => "Access denied."
          end
        end
        render :json => @user
      end

      private

      def admin_only
        unless current_user.admin?
          redirect_to :back, :alert => "Access denied."
        end
      end

      def secure_params
        params.require(:user).permit(:role)
      end
    end
  end
end
