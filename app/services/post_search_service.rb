class PostSearchService
  def self.search(posts, query)
    posts.where('title LIKE ?', "%#{query}%")
  end
end