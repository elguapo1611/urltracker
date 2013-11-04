class Page < ActiveRecord::Base
  attr_accessible :url, :dom_selectors_attributes

  validates_uniqueness_of :url

  has_many :crawls
  has_many :dom_selectors
  belongs_to :user

  accepts_nested_attributes_for :dom_selectors

  def crawl
    response = Typhoeus.get(url, followlocation: true)
    if response.response_code == 200 && audit(response.body).has_changes?
      Crawl.create(:body => response.body, :page_id => id)
    end
  end

  def previous_crawl
    last_two_crawls[0]
  end

  def previous_crawl_comparison
    last_two_crawls[1]
  end 

  def audit(current_crawl_body=nil)
    Audit.new(current_crawl_body || previous_crawl_comparison.try(:body), previous_crawl.try(:body), dom_selectors)
  end

  def dom_selectors_to_s
    dom_selectors.map{|dom_selector| dom_selector.path}.join(", ")
  end

  private

  def last_two_crawls
    @last_two_crawls ||= crawls.order("created_at DESC").limit(2)
  end

end
