class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy, :import, :analyze]

  def index
    @reports = Report.all
  end

  def show; end

  def new
    @report = Report.new
  end

  def edit; end

  def create
    @report = Report.new(report_params)

    if @report.save
      redirect_to @report, notice: 'Report was successfully uploaded.'
    else
      render :new
    end
  end

  def update
    if @report.update(report_params)
      redirect_to @report, notice: 'Report was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @report.destroy
    redirect_to reports_url, notice: 'Report was successfully destroyed.'
  end

  def import
    @report.import!
    redirect_to @report.becomes(Report), notice: 'Report was successfully imported.'
  end

  def analyze
    @report.analyze!
    redirect_to @report.becomes(Report), notice: 'Report was successfully analyzed.'
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:file)
  end
end
