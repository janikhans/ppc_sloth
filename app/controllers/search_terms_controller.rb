class SearchTermsController < ApplicationController
  def index
    @search_terms = SearchTerm.with_stats.order('sales desc')
  end

  def show
    @search_term = SearchTerm.find(params[:id])
    @search_term_report_items = @search_term.search_term_report_items
  end
end
