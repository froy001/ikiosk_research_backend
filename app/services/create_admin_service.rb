class CreateAdminService
  def call
    user = User.find_or_create_by!(email: Figaro.env.admin_email) do |user|
        user.password = Figaro.env.admin_password
        user.password_confirmation = Figaro.env.admin_password
        user.confirmed_at = Time.now
        user.name = Figaro.env.admin_name
        user.admin!
      end
  end
end
