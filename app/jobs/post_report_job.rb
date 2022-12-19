class PostReportJob < ApplicationJob
  queue_as :default

  def perform(user_id, post_id)
    user = User.find(iser_id)
    post = Post.find(post_id)
    report = PostReport.generate(post)
    # Do something later
    # user -> post report -> send by email
  end
end
