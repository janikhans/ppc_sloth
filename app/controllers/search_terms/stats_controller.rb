module SearchTerms
  class StatsController < ApplicationController
    before_action :set_search_term

    def impressions
      render json: @search_term.search_term_report_items.group_by_day(:date).sum(:impressions)
    end

    def clicks
      render json: @search_term.search_term_report_items.group_by_day(:date).sum(:clicks)
    end

    private

    def set_search_term
      @search_term = SearchTerm.find(params[:search_term_id])
    end
  end
end
