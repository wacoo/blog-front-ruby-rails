class CustomLinkRenderer < WillPaginate::ActionView::LinkRenderer
    def container_attributes
      super.except(:first_label, :last_label, :previous_label, :next_label)
    end
  
    def previous_or_next_page(page, text, classname)
      if page
        tag(:li, link(text, page, class: classname))
      else
        tag(:li, tag(:span, text), class: classname + ' disabled')
      end
    end
  
    def page_number(page)
      if page == current_page
        tag(:li, link(page, page, rel: rel_value(page)), class: 'active')
      else
        tag(:li, link(page, page, rel: rel_value(page)))
      end
    end
  end