module Commands
  def with_typing
    message.typing_on
    yield
    message.typing_off
  end
end
