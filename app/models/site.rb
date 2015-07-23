class Site < ActiveRecord::Base
	 

	 has_many :links, dependent: :destroy


# --------------------------------------------------

  def save_links
  	links_to_be_saved = []

    contents = Nokogiri::HTML(Typhoeus.get(self.url).response_body)
    contents.css('a').each do |link|
      unless link.nil? or link.attributes.nil? or link.attributes['href'].nil?
        link_href = link.attributes['href'].value
        if link_href.starts_with? '/'
          link_href = self.url + link_href
        end

        if link_href.starts_with? 'http://', 'https://'
          links_to_be_saved << self.links.new(url: link_href)
        end
      end
    end
    Link.import(links_to_be_saved)
    # comes from the active record install gem
  end

# --------------------------------------------------

  def check_links
  		
  		self.links.each do |link|
		response = Typhoeus.get(link.url)
        link.update_attributes(http_response: response.response_code)
  		end	
  end









end
