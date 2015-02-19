namespace :fake_data do
  # this rake task generates 3 fake users, and each user has 2 questions answered.
  # 5 questions (those each with 3 questions).. 

  desc "generate fake users, questions, and answers data for NormalCC project testing."
  task :uqa => :environment do #user, question, answer --> uqa

    all_years = []
    for i in 1910..2015 do
      all_years.push i 
    end 

    # generate 3 user
    3.times do |n|
      User.create(email: "sample#{n+2}@email.com", female: [true, false].sample, birth_year: all_years.sample, country: Country.all.sample)
    end

    5.times do
      question = Question.create(title: Faker::Lorem.sentence(4) )

      3.times do
        question.answers.create(title: Faker::Company.bs, question: Question.all.sample)
      end
    end

    User.all.each do |u|
      # generate random Scorecard pairings between users and questions
      2.times do
        u.scorecards.create(answer: Answer.all.sample )
      end
    end

  end
end