class AssetFinder
 
  def initialize(page)
    @page = page
  end

  def find_all
    assets = find_js_scripts << find_css_stylesheets << find_images << find_hyperlinks
    assets = assets.flatten
    assets = assets.uniq
    assets
  end

  def find_hyperlinks
    find_resource("a", "href")
  end

  def find_js_scripts
    find_resource("script", "src")  
  end

  def find_css_stylesheets
    find_resource("link", "href")
  end

  def find_images
    find_resource("img", "src")
  end 

  private

  def find_resource(component_type, component_attr)
    resources = []
    css_components = page.css("#{component_type}")
    css_components.each do |component|
      attribute = component.attributes["#{component_attr}"]
      resources << attribute.value unless resource_invalid?(component_type, attribute)
    end
    
    resources
  end

  def resource_invalid?(type, attribute)
    attribute.nil? || attribute.value.nil?  
  end

  def page
    @page
  end
end
