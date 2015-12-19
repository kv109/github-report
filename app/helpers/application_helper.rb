module ApplicationHelper
  def ajaxify(&block)
    content_tag :div, data: { ajaxify: true } do
      if params[:partial]
        block.call
      end
    end
  end
end
