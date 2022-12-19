class PostSearchService
  def self.search(posts, query)
    posts_ids = Rails.cache.fetch("posts_search/#{query}", expires_in: 1.hours) do
      posts.where('title LIKE ?', "%#{query}%").pluck(:id)
    end

    posts.where(id: posts_ids)
  end
end