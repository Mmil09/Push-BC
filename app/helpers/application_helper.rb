module ApplicationHelper
  
  def active_url?(address)
   "class = active".html_safe if current_page?(address)
  end

  def navbar_link(title, address)
    render('layouts/navigation_item', title: title, address: address )
  end

  def menu_button(text, path)
    render('layouts/button', text: text, path: path)
  end

  def display_button_logged_in(text, path)
    menu_button(text, path) if logged_in?
  end

  def display_button_logged_out(text, path)
    menu_button(text, path) if logged_in?
  end

  def display_login
    render('/layouts/login_form/login_menu') if !logged_in?
  end

  def display_account
    render('/layouts/login_form/account_menu') if logged_in?
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