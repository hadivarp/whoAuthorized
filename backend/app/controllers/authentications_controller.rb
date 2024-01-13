class AuthenticationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

  before_action :authenticate_request, only: [:sign_out]


  def sign_up
    user = User.find_by(email: user_params['email'])
    if user
      render json: { message: "User already exists" }, status: :unprocessable_entity
    else
      user = User.new(user_params)
      if user.save
        @token = JsonWebToken.encode(user_id: user.id)
        expiration = 1.day.from_now
        user.access_tokens.create(token: @token, expires_at: expiration)

        render json: { message: "User created successfully", user: { id: user.id, email: user.email },token: @token }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end




  def sign_in
    @user = User.find_by(email: user_params['email'])
      if @user && @user.authenticate(user_params['password'])
        @token = JsonWebToken.encode(user_id: @user.id)
      render json: {
        message: "User login successfully", user: { id: @user.id, email: @user.email }, token: @token
      }, status: :accepted
    else
      render json: { message: 'Incorrect email or password' }, status: :unauthorized
    end
  end


  def sign_out

    render json: { message: "User signed out successfully" }, status: :ok
  end




  private

  def user_params
    params.require(:authentication).permit(:name,:last_name, :email,:password)
  end

  def handle_invalid_record(e)
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end


  def authenticate_request
    header = request.headers['Authorization']

    begin
      if header.present?
        @decode = JsonWebToken.decode(header)
        @current_user = User.find(@decode['user_id'])
      else
        head :unauthorized
      end
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError
      head :unauthorized
    end
  end


end
