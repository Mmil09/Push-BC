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

  def model_backed?(form)
    true if form != nil
  end

  def display_text_field_label(form, label)
    if model_backed?(form)
      form.label label
    else
      label_tag label
    end
  end

  def display_text_field_element(form, name, type)
    if model_backed?(form)
      form.send("#{type}_field", name, {class: "form-control"})
    else
      send("#{type}_field_tag", name, '', { class: "form-control" })
    end
  end


end
