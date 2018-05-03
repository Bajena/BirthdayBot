module Commands
  BIRTHDAY_DATE = "2018-05-03".freeze

  def start
    return start_basic if Date.today.to_s != BIRTHDAY_DATE

    quiz_state.won? ? start_basic : start_with_quiz
  end

  def start_with_quiz
    text = if quiz_state.won?
      "Wygrałaś już, serio chcesz zacząć ponownie?"
    else
      "Cześć Bluperku, wszystkiego najlepszego! Z okazji urodzin "\
      "przygotowałem dla Ciebie parę niespodzianek, ale zanim je otrzymasz "\
      " musisz rozwiązać mały quiz. Masz ochotę wziąć w nim udział?"
    end

    say text, quick_replies: [
      ['Jasne!', 'quiz_start_ok'], ['Nie', 'quiz_start_no']
    ]
    next_command :quiz_handle_start
  end

  def start_basic
    say 'Cześć Bluperku, jak mogę ci dzisiaj poprawić humor?'
  end
end
