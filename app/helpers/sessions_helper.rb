module SessionsHelper
  def current_administrator?(administrator)
    administrator == current_administrator
  end

  def signed_in?
   !current_administrator.nil?
  end
end
