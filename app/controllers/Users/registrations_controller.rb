# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    resource.full_name = "#{params[:user][:first_name]} #{params[:user][:last_name]}"
    if resource.save
      set_flash_message! :notice, :signed_up
      sign_in(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    end
  end

  # GET /resource/edit
  def edit
    render :edit
  end

  # PUT /resource
  def update
    resource.full_name = "#{params[:user][:first_name]} #{params[:user][:last_name]}"
    if update_resource(resource, account_update_params)
      set_flash_message! :notice, 'Account Updated'
      sign_in(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

  def account_update_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :full_name, :email, :password, :first_name, :last_name, :password_confirmation ])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [ :full_name, :email, :password, :first_name, :last_name, :password_confirmation, :current_password ])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
end
