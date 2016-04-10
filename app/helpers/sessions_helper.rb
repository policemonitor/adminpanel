module SessionsHelper
  ADMIN_RANK = 1
  HR_RANK = 2

  def current_administrator?(administrator)
    administrator == current_administrator
  end

  def signed_in?
   !current_administrator.nil?
  end

  def signed_in_ADMIN?
    current_administrator.rank == ADMIN_RANK
  end

  def signed_in_HR?
    current_administrator.rank == HR_RANK
  end
end
