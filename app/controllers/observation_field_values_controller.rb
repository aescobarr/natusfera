class ObservationFieldValuesController < ApplicationController
  doorkeeper_for :show, :create, :update, :destroy, :if => lambda { authenticate_with_oauth? }
  before_filter :authenticate_user!, :except => [:index], :unless => lambda { authenticated_with_oauth? }
  before_filter :load_observation_field_value, :only => [:update, :destroy]

  def index
    per_page = params[:per_page].to_i
    per_page = 30 if (per_page <= 0 || per_page > 200)
    @ofvs = ObservationFieldValue.
      includes(:observation_field, :observation => [{:taxon => [:source]}, :user]).
      page(params[:page]).per_page(per_page)
    @ofvs = @ofvs.datatype(params[:type]) unless params[:type].blank?
    @ofvs = @ofvs.field(params[:field]) unless params[:field].blank?
    @ofvs = @ofvs.license(params[:license]) unless params[:license].blank?
    pagination_headers_for(@ofvs)
    respond_to do |format|
      format.json do
        taxon_json_opts = {:only => [:id, :name, :rank], :include => [:source]}
        if params[:type] == ObservationField::TAXON
          taxa = Taxon.includes(:source).where("id IN (?)", @ofvs.map{|ofv| ofv.value.to_i}.compact.uniq).index_by(&:id)
          @ofvs.each_with_index do |ofv,i| 
            @ofvs[i].taxon = taxa[@ofvs[i].value.to_i].as_json(taxon_json_opts)
          end
        end
        render :json => @ofvs.to_json(
          :methods => [:taxon],
          :include => {
            :observation_field => {
              :only => [:id, :datatype, :name]
            }, 
            :observation => {
              :only => [:id, :license, :latitude, :longitude, :positional_accuracy, :observed_on],
              :methods => [:time_observed_at_utc, :coordinates_obscured],
              :include => {
                :taxon => taxon_json_opts, 
                :user => {:only => [:id, :name, :login]}
              }
            }
          }
        )
      end
    end
  end
  
  def create
    @observation_field_value = ObservationFieldValue.new(params[:observation_field_value])
    if !@observation_field_value.valid?
      if existing = ObservationFieldValue.where(
          "observation_field_id = ? AND observation_id = ?", 
          @observation_field_value.observation_field_id, 
          @observation_field_value.observation_id).first
        @observation_field_value = existing
        @observation_field_value.attributes = params[:observation_field_value]
      end
    end
    
    respond_to do |format|
      if @observation_field_value.save
        format.json { render :json => @observation_field_value }
      else
        format.json do
          render :status => :unprocessable_entity, :json => { :errors => @observation_field_value.errors.full_messages }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @observation_field_value.update_attributes(params[:observation_field_value])
        format.json { render :json => @observation_field_value }
      else
        format.json do
          render :status => :unprocessable_entity, :json => { :errors => @observation_field_value.errors.full_messages }
        end
      end
    end
  end
  
  def destroy
    if @observation_field_value.blank?
      status = :gone
      json = "Observation field value #{params[:id]} does not exist."
    elsif @observation_field_value.observation.user_id != current_user.id
      status = :forbidden
      json = "You do not have permission to do that."
    else
      @observation_field_value.destroy
      status = :ok
      json = nil
    end
    
    respond_to do |format|
      format.any do
        render :status => :status, :text => json
      end
      format.json do 
        render :status => status, :json => json
      end
    end
  end

  private
  def load_observation_field_value
    @observation_field_value = ObservationFieldValue.find_by_id(params[:id])
    render_404 unless @observation_field_value
  end
end
