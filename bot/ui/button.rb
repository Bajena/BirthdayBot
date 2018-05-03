module UI
  ########################### OPEN GRAPH TEMPLATE #############################
  # https://developers.facebook.com/docs/messenger-platform/send-messages/template/button
  class Button
    def initialize(type: "web_url", title:, options: {})
      @template = {
        type: type,
        title: title
      }.merge(options)
    end

    attr_reader :template
  end
end
