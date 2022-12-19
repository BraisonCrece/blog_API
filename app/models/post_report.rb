class PostReport < Struct.new(:word_count, :word_histogram, :letter_histogram)
  def self.generate(post)
    PostReport.new(
      # word count
      post.content.split.map { |word| word.gsub(/\W/,'') }.count,
      # word histogram
      calc_word_histogram(post),
      #letter histogram
      calc_letter_histogram(post)
    )
  end

  private

  def self.calc_word_histogram(post)
    (post
      .content
      .split
      .map { |word| word.gsub(/\W/,'') }
      .map(&:downcase)
      .group_by { |word| word }.transform_values(&:size))
  end


  def self.calc_letter_histogram(post)
    (post
      .content
      .split("")
      .filter { |word| word.match(/[a-zA-Z]/) }
      .map(&:downcase)
      .group_by { |word| word }.transform_values(&:size))
  end
end