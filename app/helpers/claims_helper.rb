module ClaimsHelper
  FIRST_PARAGRAPH_SIZE = 1000
  LIST_SIZE = 2600
  LAST_PARAGRAPH_SIZE = 430

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
                "#{'<h5>Вже розглядається!</h5>' if is_under_viewing(claim)}" +
                "<p>" + claim.text.truncate(200) + "</p>
                  <div class='btn-group pull-right'>
                    <a href='"+ claim_path(claim) + "' class='btn btn-primary' data-turbolink='false' >Деталі</a>" +
                    "<a href='"+ edit_claim_path(claim) + "' class='btn btn-primary' data-turbolink='false' >Наказ</a>" +
                 "</div>
              </div>"
    return message.html_safe
  end

  def claim_cut_to_document(text)
    paragraphs = []
    paragraphs << text.slice!(0, FIRST_PARAGRAPH_SIZE)

    while text.length > LIST_SIZE
      paragraphs << text.slice!(0, LIST_SIZE)
    end

    paragraphs << text if !text.empty?

    if paragraphs.last.length >= (LIST_SIZE - LAST_PARAGRAPH_SIZE)
      paragraphs << []
    end
    return paragraphs
  end

  def is_under_viewing(claim)
    return claim.access != nil ? true : false
  end
end
