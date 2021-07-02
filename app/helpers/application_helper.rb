module ApplicationHelper
  def choose_new_or_edit
    if action_name == 'edit'
      admin_user_path
    else
      admin_users_path
    end
  end
end
