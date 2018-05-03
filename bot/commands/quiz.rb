module Commands
  def quiz_handle_start
    message.typing_on
    case message.quick_reply
    when "quiz_start_ok"
      quiz_state.reset!
      ask_question
    when "quiz_start_no"
      say "Nie to nie :/"
      stop_thread
    else
      say "🤖"
      stop_thread
    end
    message.typing_off
  end

  def ask_question
    say current_question.text, quick_replies: current_question.quick_replies

    next_command :handle_answer
  end

  def handle_answer
    answer = current_question.answer_for(message.quick_reply)

    unless answer
      say "Nie ma takiej odpowiedzi. Spróbuj ponownie."
      ask_question
      return
    end

    if answer.valid?
      say "Brawo!"
      quiz_state.add_point!
    else
      say "Niestety, zła odpowiedź"
    end

    print_score

    return handle_finish if quiz_state.finished?

    quiz_state.next_question!
    ask_question
  end

  private

  def handle_finish
    if quiz_state.won?
      say "Wygrywasz!"
    elsif quiz_state.lost?
      say "Koniec quizu. Niestety, masz za mało punktów. Spróbuj jeszcze raz."
    end

    stop_thread
  end

  def print_score
    message.typing_on

    say "Wynik: #{quiz_state.points}"

    message.typing_off
  end

  def current_question
    quiz_state.current_question
  end

  def quiz_state
    Quiz::State.new(@user)
  end
end
