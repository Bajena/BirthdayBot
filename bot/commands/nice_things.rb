module Commands
  NICE_THING_REPLIES = [
    ["Wyślij mi zdjęcie", "send_photo"],
    ["Wyślij mi fajną piosenkę", "send_song"],
    ["Powiedz coś miłego", "send_text"],
    ["Nie wiem, wymyśl coś", "send_random"],
    ["Nic, dzięki", "send_nothing"]
  ].freeze

  PHOTO_URLS = [
    "https://typefast.blog/wp-content/uploads/2018/02/ruby-1000x1000.jpg"
  ].freeze

  SONG_URLS = [
    "https://open.spotify.com/track/7GhIk7Il098yCjg4BQjzvb"
  ].freeze

  NICE_TEXTS = [
    "Jesteś super!"
  ]

  THINKING_TEXTS = [
    "Co by tu wysłać, hmmmm... Mam:",
    "Łap:",
    "Już wiem! Obczaj to:",
    "Hmmm... wiem:"
  ].freeze

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

    say "Chciałabyś coś jeszcze?", quick_replies: NICE_THING_REPLIES
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

  def show_thinking_text
    with_typing do
      say THINKING_TEXTS.sample
    end
  end

  def send_random_song
    show_thinking_text

    send_song SONG_URLS.sample
  end

  def send_random_photo
    show_thinking_text

    send_song PHOTO_URLS.sample
  end

  def send_random_text
    with_typing do
      say NICE_TEXTS.sample
    end
  end

  def send_photo(url)
    image = UI::ImageAttachment.new(url)
    show(image)
  end

  def send_song(url)
    show(UI::OpenGraphTemplate.new(url))
  end
end
