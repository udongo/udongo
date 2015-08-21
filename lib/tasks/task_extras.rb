module TaskExtras
  def user_input(message, field = nil)
    if field && ENV[field.to_s]
      ENV[field.to_s]
    else
      puts message
      STDIN.gets.strip
    end
  end
end
