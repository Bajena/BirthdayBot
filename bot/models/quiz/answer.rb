module Quiz
  class Answer
    def initialize(text:, question_index:, index:, valid:)
      @text = text
      @question_index = question_index
      @index = index
      @valid = valid
    end

    def valid?
      @valid
    end

    def quick_reply_text
      "(#{letter}) #{text}"
    end

    def quick_reply_id
      "quiz_question_#{question_index}_#{index}"
    end

    private

    CAPITAL_A_ASCII_NUMBER = 65

    attr_reader :index, :text, :question_index

    def letter
      (CAPITAL_A_ASCII_NUMBER + index).chr
    end
  end
end
