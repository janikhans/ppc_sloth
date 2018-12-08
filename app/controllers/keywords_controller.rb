class KeywordsController < ApplicationController
  def index
    @keywords = Keyword.where.not(match_type: [:negative_phrase, :negative_exact])
                  .enabled
                  .with_stats
                  .order('impressions desc NULLS LAST')
  end

  def show
    @keyword = Keyword.find(params[:id])
    @search_term_report_items = @keyword.search_term_report_items
  end
end
