class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :published, :author

  # author is not a column in the posts table, so we need to define it
  def author
    {
      id: object.user.id,
      name: object.user.name,
      email: object.user.email
    }
  end
end
