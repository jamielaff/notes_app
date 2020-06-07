module UsersHelper
  def user_submit_button_text
    if logged_out?
      'Signup'
    elsif @user.new_record?
      'Create'
    else
      'Update account'
    end
  end
end
