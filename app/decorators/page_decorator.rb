class PageDecorator < Draper::Decorator
  delegate_all

  def display_title
    home? ? h.render('jumbo') : "<h3>#{self.page.title}</h3>".html_safe 
  end

  private 

  def home?
    true if self.page.title == 'Home'
  end

end