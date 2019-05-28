class SuggestionsController < ApplicationController
  def index
    @skus = Sku.all
    @form = SearchTermIdentifier.new(params[:search])
    @search_terms = @form.search_terms
  end
end
