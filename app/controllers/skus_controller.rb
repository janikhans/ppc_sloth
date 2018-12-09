class SkusController < ApplicationController
  before_action :set_sku, only: [:show, :edit, :update, :destroy]

  def index
    @skus = Sku.all
  end

  def show
    @ad_groups = @sku.ad_groups
  end

  def new
    @sku = Sku.new
  end

  def edit; end

  def create
    @sku = Sku.new(sku_params)

    if @sku.save
      redirect_to @sku, notice: 'Sku was successfully created.'
    else
      render :new
    end
  end

  def update
    if @sku.update(sku_params)
      redirect_to @sku, notice: 'Sku was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @sku.destroy
    redirect_to skus_url, notice: 'Sku was successfully destroyed.'
  end

  private

  def set_sku
    @sku = Sku.find(params[:id])
  end

  def sku_params
    params.require(:sku).permit(:name, :asin)
  end
end
