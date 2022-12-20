class PostReportMailer < ApplicationMailer
  def post_report(user, post, post_report)
    @post = post
    @post_report = post_report
    mail to: user.email, subject: "Post #{post.id} report"
  end
end
