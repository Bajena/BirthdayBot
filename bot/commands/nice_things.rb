module Commands
  NICE_THING_REPLIES = [
    ["Wyślij mi zdjęcie", "send_photo"],
    ["Wyślij mi piosenkę", "send_song"],
    ["Powiedz coś miłego", "send_text"],
    ["Nie wiem, wymyśl coś", "send_random"],
    ["Nic, dzięki", "send_nothing"]
  ].freeze

  def help
    say "Co chciałabyś, żebym zrobił?", quick_replies: NICE_THING_REPLIES
    next_command :send_nice_thing
  end

  def send_nice_thing
    case message.quick_reply
    when "send_song" then send_random_song
    when "send_photo" then send_random_photo
    when "send_text" then send_random_text
    when "send_random" then send_random_thing
    when "send_nothing"
      say "Ok, pisz, jakbyś czegoś potrzebowała ;)"
      stop_thread
      return
    else
      say "Chyba nie ogarnąłem o co chodzi :/"
      stop_thread
      return
    end
  end

  def send_random_thing
    todo = [
      :send_random_song,
      :send_random_photo,
      :send_random_text
    ].sample

    send(todo)
  end

  private

  def want_more?
    say "Chciałabyś coś jeszcze?", quick_replies: NICE_THING_REPLIES
    next_command :send_nice_thing
  end

  def show_thinking_text
    say THINKING_TEXTS.sample
  end

  def send_random_song
    show_thinking_text

    with_typing do
      send_song SONG_URLS.sample
    end

    want_more?
  end

  def send_random_photo
    show_thinking_text

    with_typing do
      photo = PHOTO_URLS.sample
      puts "Sending photo: #{photo}"
      send_photo(photo)
    end

    want_more?
  end

  def send_random_text
    with_typing do
      say NICE_TEXTS.sample
    end

    want_more?
  end

  def send_photo(url)
    image = UI::ImageAttachment.new(url)
    show(image)
  end

  def send_song(url)
    show(UI::OpenGraphTemplate.new(url))
  end

  THINKING_TEXTS = [
    "Co by tu wysłać, hmmmm... Mam:",
    "Łap:",
    "Obczaj to:",
    "Hmmm... wiem:"
  ].freeze
end
