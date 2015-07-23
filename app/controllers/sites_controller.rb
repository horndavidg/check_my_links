class SitesController < ApplicationController
  



  def index
@sites = Site.all
  end

# -----------------------------------

  def new
  	 @site = Site.new
  end

# -----------------------------------

 def create
    # url = params.require(:site)[:url]
    @site = Site.create(site_params)
    @site.save_links
    LinksWorker.perform_async(@site.id)
    # binding.pry
    redirect_to site_path(@site.id)
 end 

# -----------------------------------

  def show
  	@site = Site.find(params[:id])
    @links = @site.links
    # binding.pry
  end

# -----------------------------------

def destroy

	Site.destroy_all
	redirect_to sites_path
	
end




# ---------------------------------------------

private

  def site_params
  	params.require(:site).permit(
  		:url
  		)
  end



end