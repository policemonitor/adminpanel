module CrewsHelper
  def flash_errors crew
    notice = "Виникли помилки. Усього їх #{crew.errors.count}.<ul>"
    crew.errors.full_messages.each do |msg|
      notice += "<li>#{msg}</li>"
    end
    notice += "</ul>"
    return notice
  end

  def gps_unreachable crew
    return (crew.latitude == nil || crew.longitude == nil) ? true : false
  end
end
