class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]

  def index
    @campaigns = Campaign.with_stats.order('sales desc')
  end

  def show
    @ad_groups = @campaign.ad_groups
    @aggregate_stats = @campaign.aggregate_stats
  end

  def new
    @campaign = Campaign.new
  end

  def edit; end

  def create
    @campaign = Campaign.new(campaign_params)

    if @campaign.save
      redirect_to @campaign, notice: 'Campaign was successfully created.'
    else
      render :new
    end
  end

  def update
    if @campaign.update(campaign_params)
      redirect_to @campaign, notice: 'Campaign was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @campaign.destroy
    redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.'
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  def campaign_params
    params.require(:campaign).permit(:name)
  end
end
