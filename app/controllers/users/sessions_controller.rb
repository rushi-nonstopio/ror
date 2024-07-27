class Users::SessionsController < Devise::SessionsController
  after_action :redirect_after_sign_out, only: [:destroy]

  private

  def redirect_after_sign_out
    if request.referer == destroy_user_session_url
      flash[:notice] = "You have been logged out successfully"
      redirect_to new_user_session_path, status: :see_other
    end
  end
end
