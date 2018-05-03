module UI
  ########################### OPEN GRAPH TEMPLATE #############################
  # https://developers.facebook.com/docs/messenger-platform/send-messages/template/open-graph
  class OpenGraphTemplate
    def initialize(url, button: nil)
      @url = url
      @button = button

      @template = {
        recipient: {
          id: nil
        },
        message: {
          attachment: {
            type: "template",
            payload: {
              template_type: "open_graph",
              elements: elements
            }
          }
        }
      }
    end

    # Sends the valid JSON to Messenger API
    def send(user)
      formed = build(user)
      Bot.deliver(formed, access_token: ENV['ACCESS_TOKEN'])
    end

    # Use this method to return a valid hash and save it for later
    def build(user)
      @template[:recipient][:id] = user.id
      @template
    end

    private

    attr_reader :url, :button

    def elements
      res = { url: url }
      res.merge!(button: button.template) if button

      [res]
    end
  end
end
