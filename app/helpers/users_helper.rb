module UsersHelper

  def approval_table(f)
    if current_user.role == 'admin' and f.length != 0
      render partial: "users/approval_leave.html.erb", locals: {f: f}
    end
  end
end
