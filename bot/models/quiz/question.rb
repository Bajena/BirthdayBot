module Quiz
  class Question
    QUESTIONS = [
      {
        text: "Kto najbardziej kocha Oluśkę?",
        answers: ["Lemik", "Topek", "Jasiaczek", "Don Arkada"],
        valid_answer: 2
      },
      {
        text: "Ile przebiegliśmy razem półmaratonów?",
        answers: ["2", "3", "4", "5"],
        valid_answer: 3
      }
    ]

    def self.questions_count
      QUESTIONS.length
    end

    def self.find(index)
      data = QUESTIONS[index]
      return unless data

      new(data: data, index: index)
    end

    def initialize(data:, index:)
      @data = data
      @index = index
    end

    attr_reader :index

    def answer_for(quick_reply_id)
      answers.find { |a| a.quick_reply_id == quick_reply_id }
    end

    def last?
      index == self.class.questions_count - 1
    end

    def text
      data[:text]
    end

    def quick_replies
      answers.map { |a| [a.quick_reply_text, a.quick_reply_id] }
    end

    private

    attr_reader :data

    def answers
      data[:answers].map.with_index do |text, i|
        Quiz::Answer.new(
          text: text,
          index: i,
          question_index: index,
          valid: data[:valid_answer] == i
        )
      end
    end
  end
end
