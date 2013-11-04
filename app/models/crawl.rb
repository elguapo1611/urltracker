class Crawl < ActiveRecord::Base
  attr_accessible :body, :page_id
  belongs_to :page

  def hexdigest
    Digest::SHA2.hexdigest(body)
  end

end
