module AdministratorsHelper
  def flash_errors(administrator)
    notice = "Виникли помилки. Усього їх #{administrator.errors.count}.<ul>"
    administrator.errors.full_messages.each do |msg|
      notice += "<li>#{msg}</li>"
    end
    notice += "</ul>"
  end
end
