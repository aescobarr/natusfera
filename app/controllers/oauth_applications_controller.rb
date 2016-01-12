class OauthApplicationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_application, :only => [:show, :edit, :update, :destroy]
  before_filter :require_owner_or_admin, :only => [:edit, :update, :destroy]
  respond_to :html

  def index
    @applications = Doorkeeper::Application.paginate(:page => params[:page])
  end

  def new
    @application = Doorkeeper::Application.new
  end

  def create
    @application = Doorkeeper::Application.new(params[:application] || params[:oauth_application])
    @application.owner = current_user
    if @application.save
      flash[:notice] = I18n.t(:notice, :scope => [:doorkeeper, :flash, :applications, :create])
      respond_with [:oauth, @application]
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @application.update_attributes(params[:application] || params[:oauth_application])
      flash[:notice] = I18n.t(:notice, :scope => [:doorkeeper, :flash, :applications, :update])
      respond_with [:oauth, @application]
    else
      render :edit
    end
  end

  def destroy
    flash[:notice] = I18n.t(:notice, :scope => [:doorkeeper, :flash, :applications, :destroy]) if @application.destroy
    redirect_to oauth_applications_url
  end

  private

  def load_application
    render_404 unless @application = Doorkeeper::Application.find_by_id(params[:id])
    @application = @application.becomes(OauthApplication)
  end

  def require_owner_or_admin
    unless logged_in? && (current_user.id == @application.owner_id || current_user.admin?)
      flash[:error] = "You don't have permission to do that"
      return redirect_to root_url
    end
  end
end
