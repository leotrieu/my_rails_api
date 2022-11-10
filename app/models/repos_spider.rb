class ReposSpider < Kimurai::Base
  @name = 'items_spider'
  @engine = :selenium_firefox
  @config = {
    headless_mode: :native
  }

  @@items_array = []

  def self.list
    @@items_array
  end

  def self.process()
    url = 'https://github.com/sponsors/explore'
    @start_urls = [url]
    self.crawl!
  end

  def parse(response, url:, data: {})    
    response.search("div.js-featured-accounts article").each do |element|      
      image = element.css('img').attr('src')
      name = element.css('h1 a').text
            
      item = {
        image: image,
        name: name        
      }
      @@items_array.push(item)
    end
  end

end