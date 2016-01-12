class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource
    resource.site = @site
    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with(resource) do |format|
          format.any(:html, :mobile) do
            if session[:return_to_for_new_user]
              redirect_to session[:return_to_for_new_user]
            else
              redirect_to home_path
            end
          end
          format.json do
            render :json => resource.as_json(User.default_json_options)
          end
        end
        return
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        redirect_to root_url
        return
      end
    else
      clean_up_passwords resource
      respond_with(resource) do |format|
        format.html { render :new }
        format.mobile { render :new, :status => 422 }
        format.json { render :json => {:errors => resource.errors.full_messages} }
      end
    end
  end
end
