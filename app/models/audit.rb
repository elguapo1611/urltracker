class Audit
  attr_accessor :html_body, :compare_html_body, :selectors

  def initialize(html_body, compare_html_body, selectors)
    @html_body = Nokogiri::HTML(html_body)
    @compare_html_body = Nokogiri::HTML(compare_html_body)
    @selectors = selectors
  end

  def changed_selectors
    @changed_selectors ||= @selectors.reject do |selector|
      dom_element_to_hexdigest(@html_body.css(selector.path)) == dom_element_to_hexdigest(@compare_html_body.css(selector.path))
    end
  end

  def has_changes?
    !changed_selectors.empty?
  end

  private

  def dom_element_to_hexdigest(dom_element)
    Digest::SHA2.hexdigest(dom_element.text.gsub(/\s+|\n+/, ' '))
  end
end
