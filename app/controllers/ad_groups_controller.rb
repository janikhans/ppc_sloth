class AdGroupsController < ApplicationController
  before_action :set_ad_group, only: [:show, :edit, :update, :destroy]

  def index
    @ad_groups = AdGroup.all
  end

  def show
    @grouped_keywords = @ad_group.keywords.group_by(&:match_type)
  end

  def new
    @ad_group = AdGroup.new
  end

  def edit; end

  def create
    @ad_group = AdGroup.new(ad_group_params)

    if @ad_group.save
      redirect_to @ad_group, notice: 'Ad group was successfully created.'
    else
      render :new
    end
  end

  def update
    if @ad_group.update(ad_group_params)
      redirect_to @ad_group, notice: 'Ad group was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @ad_group.destroy
    redirect_to ad_groups_url, notice: 'Ad group was successfully destroyed.'
  end

  private

  def set_ad_group
    @ad_group = AdGroup.find(params[:id])
  end

  def ad_group_params
    params.require(:ad_group).permit(:campaign_id, :name)
  end
end
