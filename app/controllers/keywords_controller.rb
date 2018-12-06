class KeywordsController < ApplicationController
  def index
    @keywords = Keyword.with_stats
  end

  def show
    @keyword = Keyword.find(params[:id])
    @search_term_report_items = @keyword.search_term_report_items
  end
end
