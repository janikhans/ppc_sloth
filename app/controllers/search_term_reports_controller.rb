class SearchTermReportsController < ApplicationController
  before_action :set_search_term_report, only: [:show, :edit, :update, :destroy, :import]

  # GET /search_term_reports
  def index
    @search_term_reports = SearchTermReport.all
  end

  # GET /search_term_reports/1
  def show
    # @keywords = @search_term_report.keywords
  end

  # GET /search_term_reports/new
  def new
    @search_term_report = SearchTermReport.new
  end

  # GET /search_term_reports/1/edit
  def edit
  end

  # POST /search_term_reports
  def create
    @search_term_report = SearchTermReport.new(search_term_report_params)

    if @search_term_report.save
      redirect_to @search_term_report, notice: 'Search Term Report was successfully uploaded.'
    else
      render :new
    end
  end

  # PATCH/PUT /search_term_reports/1
  def update
    if @search_term_report.update(search_term_report_params)
      redirect_to @search_term_report, notice: 'Search Term Report was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /search_term_reports/1
  def destroy
    @search_term_report.destroy
    redirect_to search_term_reports_url, notice: 'Search Term Report was successfully destroyed.'
  end

  def import
    @search_term_report.import!
    redirect_to @search_term_report, notice: 'Search Term Report was successfully imported.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search_term_report
      @search_term_report = SearchTermReport.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def search_term_report_params
      params.require(:search_term_report).permit(:name, :file)
    end
end
