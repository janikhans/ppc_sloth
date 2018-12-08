class BulksheetsController < ApplicationController
  before_action :set_bulksheet, except: [:index, :new, :create]

  def index
    @bulksheets = Bulksheet.all
  end

  def show
  end

  def new
    @bulksheet = Bulksheet.new
  end

  def edit
  end

  def create
    @bulksheet = Bulksheet.new(bulksheet_params)

    if @bulksheet.save
      redirect_to @bulksheet, notice: 'Bulksheet was successfully created.'
    else
      render :new
    end
  end

  def update
    if @bulksheet.update(bulksheet_params)
      redirect_to @bulksheet, notice: 'Bulksheet was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @bulksheet.destroy
    redirect_to bulksheets_url, notice: 'Bulksheet was successfully destroyed.'
  end

  def import
    @bulksheet.import!
    redirect_to @bulksheet, notice: 'Bulksheet was successfully imported.'
  end

  def analyze
    @bulksheet.analyze!
    redirect_to @bulksheet, notice: 'Bulksheet was successfully analyzed.'
  end

  private

  def set_bulksheet
    @bulksheet = Bulksheet.find(params[:id])
  end

  def bulksheet_params
    params.require(:bulksheet).permit(:file)
  end
end
