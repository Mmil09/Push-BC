module ApplicationHelper
  def active_url?(address)
   "class = active".html_safe if current_page?(address)
  end

  def navbar_link(title, address)
    render('layouts/navigation_item', title: title, address: address )
  end

  def display_link_logged_in(title, address)
    navbar_link(title, address) if logged_in?
  end

  def display_link_logged_out(title, address)
    navbar_link(title, address) if !logged_in?
  end


end
