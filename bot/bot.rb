require 'rubotnik'
# require_relative all files in "bot" folder or do it by hand
Rubotnik::Autoloader.load('bot')

Rubotnik.subscribe(ENV['ACCESS_TOKEN'])

Rubotnik.set_profile(
  Profile::START_GREETING,
  Profile::START_BUTTON
)

Rubotnik.route :message do
  # Will work for all variations of these three greetings
  bind 'hi', 'hello', 'bonjour' do
    say 'Hello from your new bot!'
  end

  bind 'witam', 'cześć', 'dzień dobry', 'hejka' do
    start
  end

  bind 'quiz' do
    start_with_quiz
  end

  # Invoked if none of the commands recognized. Has to come last, after all binds
  default do
    say "Echhhh, nie umiem ci pomóc :/"
  end
end

####################### HANDLE INCOMING POSTBACKS ##############################

Rubotnik.route :postback do
  # postback from "Get Started" button
  bind 'START' do
    start
  end
end

####################### HANDLE OTHER REQUESTS (NON-FB) #########################

get '/' do
  'I can have a landing page too!'
end

############################ TEST ON LOCALHOST #################################

# 0. Have both Heroku CLI and ngrok
# 1. Set up "Messenger" app on Facebook for Developers, fill in .env
# 2. Run 'heroku local' from console, it will load Puma on port 5000
# 3. Expose port 5000 to the Internet with 'ngrok http 5000'
# 4. Provide your ngrok http_s_(!) address in Facebook Developer Dashboard
#    for webhook validation.
# 5. Open Messenger and talk to your bot!

# P.S. While you have DEBUG environment variable set to "true" (default in .env)
# All StandardError exceptions will go to the message dialog instead of
# breaking the server.
