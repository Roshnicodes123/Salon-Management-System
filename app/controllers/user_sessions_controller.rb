
class UserSessionsController < Devise::SessionsController
  skip_before_action :authenticate_user_or_barbar!, only: [:create, :destroy]

end
