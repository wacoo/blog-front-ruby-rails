class Users::SessionsController < Devise::SessionsController
  protect_from_forgery with: :null_session
  respond_to :json

  def csrf_token
    render json: { csrf_token: form_authenticity_token }
  end

  private

  def respond_with(resource, opts = {})
    if request.format.html?
      super(resource, opts)
    else
      render json: { message: 'You are logged in.' }, status: :ok
    end
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failure
  end

  def log_out_success
    render json: { message: 'You are logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Hmm nothing happened.' }, status: :unauthorized
  end
end
