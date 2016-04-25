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
                  <div class='btn-group pull-right'>
                    <a href='"+ edit_claim_path(claim) + "' class='btn btn-primary' data-turbolink='false' >Формувати наказ</a>" +
                  "</div>
                </div>"
    return message.html_safe
  end
end
