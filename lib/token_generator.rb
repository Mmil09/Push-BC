class TokenGenerator
  
  def generate_token
    confirmation_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(confirmation_token: random_token)
    end
  end
end