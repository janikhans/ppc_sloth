class KeywordsController < ApplicationController
  def index
    @keywords = Keyword.where.not(match_type: [:negative_phrase, :negative_exact])
                  .enabled
                  .with_stats
                  .order('impressions desc NULLS LAST')
  end

  def show
    @keyword = Keyword.find(params[:id])
    @search_term_report_items = @keyword.search_term_report_items.includes(:keyword, :search_term, ad_group: :campaign)
    @duplicate_keywords = Keyword.where(text: @keyword.text).includes(ad_group: :campaign).where.not(id: @keyword.id)
    @aggregate_stats = @keyword.aggregate_stats
    @skus = @keyword.skus
    @search_terms = @keyword.search_terms.with_stats.order('clicks DESC')
  end
end
