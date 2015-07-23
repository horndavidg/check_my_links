class LinksWorker
  include Sidekiq::Worker

  def perform(site_id)

# gets site form db
# calls check_links 

  site = Site.find(site_id)
  site.check_links

  end
end