module Quiz
  class Question
    QUESTIONS = [
      {
        text: "Kto najbardziej kocha Olę?",
        answers: ["Lemik", "Topek", "Jasiek", "Don Arkada"],
        valid_answer: 2
      },
      {
        text: "Gdzie zostało zrobione to zdjęcie: https://scontent-waw1-1.xx.fbcdn.net/v/t1.0-9/11159469_10204193346538265_8119553695934773430_n.jpg?_nc_cat=0&oh=b3a6e04df99cb4caa5ab8c57d4776136&oe=5B950CF0 ?",
        answers: ["Berlin", "Budapeszt", "Warszawa", "Wrocław"],
        valid_answer: 0
      },
      {
        text: "Ile przebiegliśmy razem półmaratonów?",
        answers: ["2", "3", "4", "5"],
        valid_answer: 3
      },
      {
        text: "Ile części Harry'ego Pottera razem obejrzeliśmy",
        answers: ["1", "2", "3", "4", "5"],
        valid_answer: 4
      },
      {
        text: "Ile wynosi PR Jaśka w snaczu????",
        answers: ["10kg xDD", "55kg", "60kg", "65kg"],
        valid_answer: 2
      },
      {
        text: "Skąd pochodzi to zdjęcie: https://scontent-waw1-1.xx.fbcdn.net/v/t1.0-9/11959973_10204970506086768_4725583302719490466_n.jpg?_nc_cat=0&oh=3191d57bac37dca87482dbdf48f0cde2&oe=5B56E88B ?",
        answers: ["Palermo", "Rovinji", "Valetta"],
        valid_answer: 2
      },
      {
        text: "Ulubiony gatunek muzyczny Jaśka?",
        answers: ["Jazz", "Glam Rock", "Minimal", "Eurodance"],
        valid_answer: 1
      },
      {
        text: "Gdzie zostało zrobione to zdjęcie: https://scontent-waw1-1.xx.fbcdn.net/v/t31.0-8/10955593_10203607635138080_3455013914798362246_o.jpg?_nc_cat=0&oh=cee396c84a2137e0678929c40bdf1e62&oe=5B8E553A ?",
        answers: ["Włochy", "Szwajcaria", "Polska", "Węgry"],
        valid_answer: 1
      },
      {
        text: "W którym roku się poznaliśmy?",
        answers: ["2011", "2012", "2013", "2014"],
        valid_answer: 2
      },
      {
        text: "Którego Sylwestra zostało zrobione to zdjęcie: https://scontent-waw1-1.xx.fbcdn.net/v/t1.0-9/16460_10203324442578443_3967128940867428085_n.jpg?_nc_cat=0&oh=3f0a3bb7cde893e54b2537226cb28cca&oe=5B4EC4C7 ?",
        answers: ["2013/2014", "2014/2015", "2015/2016", "2016/2017"],
        valid_answer: 1
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
