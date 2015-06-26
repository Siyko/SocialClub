class UserMailer < ApplicationMailer
  default from: 'chattysup@gmail.com'
  def admin_answer(user, comment)
    @user = user
    @comment = comment
    @url  = "http://localhost:3000/tasks/#{Task.find(comment.task_id).task_id}"
    mail(to: @user.email, subject: 'Answer at SocialClub')
  end
end
