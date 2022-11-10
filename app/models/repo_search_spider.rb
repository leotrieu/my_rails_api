class RepoSearchSpider < Kimurai::Base
  @name = 'search_spider'
  @engine = :selenium_firefox

  @@items_array = []

  def self.list
    @@items_array
  end

  def self.process(query)
    url = "https://github.com/search?q=#{query}"
    @start_urls = [url]
    self.crawl!
  end

  def parse(response, url:, data: {})
    @@items_array = []

    response.search(".repo-list li").each do |element|
      name = element.css('a.v-align-middle').text
      description = element.css('p.mb-1').text.strip
      
      item = {
        name: name,
        description: description
      }
      @@items_array.push(item)
    end
  end

end