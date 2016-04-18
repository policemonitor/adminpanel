module SessionsHelper
  ADMIN_RANK = 1
  HR_RANK = 2

  def rank_to_word(administrator)
    administrator.rank == ADMIN_RANK ? "Адміністратор" : "Керівник відділу кадрів"
  end

  def current_administrator?(administrator)
    administrator == current_administrator
  end

  def signed_in?
   !current_administrator.nil?
  end

  def is_ADMIN
    if current_administrator.nil?
      signed_in_administrator
    elsif current_administrator.rank != ADMIN_RANK
      flash[:danger] = "Недостатньо прав на виконання цієї операції!"
      redirect_to current_administrator
    end
  end

  def signed_in_ADMIN?
    current_administrator.rank == ADMIN_RANK
  end

  def signed_in_HR?
    current_administrator.rank == HR_RANK
  end

  def signed_in_administrator
    unless signed_in?
      flash[:danger] = "Увійдіть до системи!"
      redirect_to login_path
    end
  end
end
