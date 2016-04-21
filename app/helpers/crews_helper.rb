module CrewsHelper
  def flash_errors(crew)
    notice = "Виникли помилки. Усього їх #{crew.errors.count}.<ul>"
    crew.errors.full_messages.each do |msg|
      notice += "<li>#{msg}</li>"
    end
    notice += "</ul>"
    return notice
  end
end
