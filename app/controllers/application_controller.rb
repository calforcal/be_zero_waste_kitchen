class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :error_response
  rescue_from ActiveRecord::RecordInvalid, with: :error_response

  before_action :validate_api_key


  def error_response(error)
    render json: ErrorSerializer.new(error).serialize_json, status: :not_found
  end

  def validate_api_key
    if ENV['BACKEND_API_KEY'] != params[:zwk_api_key]
      render json: { message: "Bad credentials" }, status: :unauthorized
    end
  end
end