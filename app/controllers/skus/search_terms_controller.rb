module Skus
  class SearchTermsController < ApplicationController
    before_action :set_sku

    def index
      # @search_terms = @sku.customer_search_terms.with_stats_for_ad_group(@sku.ad_groups.pluck(:id))
      @search_terms = @sku.customer_search_terms.with_stats.order(:text)
    end

    private

    def set_sku
      @sku = Sku.find(params[:sku_id])
    end
  end
end
