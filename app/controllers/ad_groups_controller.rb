class AdGroupsController < ApplicationController
  before_action :set_ad_group, only: [:show, :edit, :update, :destroy]

  # GET /ad_groups
  def index
    @ad_groups = AdGroup.all
  end

  # GET /ad_groups/1
  def show
  end

  # GET /ad_groups/new
  def new
    @ad_group = AdGroup.new
  end

  # GET /ad_groups/1/edit
  def edit
  end

  # POST /ad_groups
  def create
    @ad_group = AdGroup.new(ad_group_params)

    if @ad_group.save
      redirect_to @ad_group, notice: 'Ad group was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ad_groups/1
  def update
    if @ad_group.update(ad_group_params)
      redirect_to @ad_group, notice: 'Ad group was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ad_groups/1
  def destroy
    @ad_group.destroy
    redirect_to ad_groups_url, notice: 'Ad group was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad_group
      @ad_group = AdGroup.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ad_group_params
      params.require(:ad_group).permit(:campaign_id, :name)
    end
end
