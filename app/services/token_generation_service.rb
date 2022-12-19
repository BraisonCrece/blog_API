class TokenGenerationService
  def self.generate
    # SecureRandom is a Rails module that allows to create random objects
    SecureRandom.hex
  end
end