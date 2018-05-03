module Quiz
  class State
    def initialize(user)
      @user = user

      STATES[user.id] ||= build_fresh_state
    end

    def won?
      finished? && points == Quiz::Question.questions_count
    end

    def lost?
      finished? && points < Quiz::Question.questions_count
    end

    def finished?
      current_question.last?
    end

    def current_question
      Quiz::Question.find(current_question_index)
    end

    def next_question!
      state[:current_question] = state[:current_question] + 1
    end

    def add_point!
      state[:points] = points + 1
    end

    def points
      state[:points]
    end

    def reset!
      STATES[user.id] = build_fresh_state
    end

    private

    STATES = {}

    attr_reader :user

    def state
      STATES[user.id]
    end

    def build_fresh_state
      {
        points: 0,
        current_question: 0
      }
    end

    def current_question_index
      state[:current_question]
    end
  end
end
