class ZonesController < ApplicationController
  before_action :set_zone, only: [:show, :edit, :update, :destroy, :commit]

  def index
    @zones = Zone.all
  end

  def show
  end

  def new
    @zone = Zone.new
  end

  def edit
  end

  def create
    @zone = Zone.new(zone_params)

    if @zone.save
      redirect_to @zone, notice: 'Zone was successfully created.'
    else
      render :new
    end
  end

  def update
    if @zone.update(zone_params)
      redirect_to @zone, notice: 'Zone was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @zone.destroy
    redirect_to zones_url, notice: 'Zone was successfully destroyed.'
  end

  def commit
    @zone.records.each do |record|
      record.committed = true
      record.save
    end
    redirect_to zone_records_path(@zone)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zone
      fqdn = params[:fqdn] || params[:zone_fqdn]
      @zone = Zone.find_by(fqdn: fqdn)
      raise ActionController::RoutingError.new('Not Found') if @zone.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def zone_params
      params.require(:zone).permit(:fqdn, :parent_zone_id, :pseudo_zone, :description)
    end
end
