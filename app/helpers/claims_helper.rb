module ClaimsHelper
  def flash_errors(claim)
    notice = "Виникли помилки. Усього їх #{claim.errors.count}.<ul>"
    claim.errors.full_messages.each do |msg|
      notice += "<li>#{msg}</li>"
    end
    notice += "</ul>"
    return notice
  end
end
