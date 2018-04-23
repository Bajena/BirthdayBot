module Profile
  # Configure profile for your bot (Start Button, Greeting, Menu)

  START_BUTTON = {
    get_started: {
      payload: 'START'
    }
  }

  START_GREETING = {
    greeting: [
      {
        locale: 'default',
        text: "Cześć {{user_first_name}}!"
      }
    ]
  }

  SIMPLE_MENU = {
    persistent_menu: [
      {
        locale: 'default',
        # If this option is set to true,
        # user will only be able to interact with bot
        # through the persistent menu
        # (composing a message will be disabled)
        composer_input_disabled: false,
        call_to_actions: [
          {
            type: 'postback',
            title: 'klik',
            payload: 'ROOT_ITEM'
          }
        ]
      }
    ]
  }
end
