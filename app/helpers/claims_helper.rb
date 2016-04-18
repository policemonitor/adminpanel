module ClaimsHelper
  def flash_errors(claim)
    notice = "Виникли помилки. Усього їх #{claim.errors.count}.<ul>"
    claim.errors.full_messages.each do |msg|
      notice += "<li>#{msg}</li>"
    end
    notice += "</ul>"
    return notice
  end

  def claim_card(claim)
    message = "<div class='messagebox'>" +
                "<h4>" + claim.theme + "</h4>" +
                "<p>" + claim.text.truncate(200) + "</p>
                  <div class='btn-group'>
                    <a href='"+ claim_path(claim) + "' class='btn btn-primary pull-right' >Формувати наказ</a>" +
                  "</div>
                </div>"
    return message.html_safe
  end
end
