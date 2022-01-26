class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name,
    :last_name_kana, :first_name_kana, :college_name, :specialty_study, :is_deleted])
  end

  private

  #ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    case resource
    when Customer
      productions_path
    when Admin
      admin_productions_path
    end
  end

  #ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource)
    if resource == :admin
      new_admin_session_path
    else
      root_path
    end
  end

end