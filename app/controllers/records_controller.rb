class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :update, :destroy]
  before_action :set_zone
  after_action :get_flash_warnings, except: :index

  def index
    @records = Record.where(zone: @zone)
  end

  def show
  end

  def new
    @record = Record.new
    @record.zone = @zone
  end

  def edit
  end

  def create
    @record = Record.new(record_params)

    if @record.save
      redirect_to [@zone, @record], notice: 'Record was successfully created.'
    else
      render :new
    end
  end

  def update
    if @record.update(record_params)
      redirect_to [@zone, @record], notice: 'Record was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @record.destroy
    redirect_to records_url, notice: 'Record was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
    end

    def set_zone
      @zone = Zone.find_by(fqdn: params[:zone_fqdn])
      raise ActionController::RoutingError.new('Not Found') if @zone.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def record_params
      params.require(:record).permit(:name, :rrtype, :ttl, :priority, :target)
    end

    def get_flash_warnings
      flash[:warning] = @record.flash_warning if @record.flash_warning.present?
      @record.flash_warning = nil
    end
end