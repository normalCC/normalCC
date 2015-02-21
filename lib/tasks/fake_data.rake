namespace :fake_data do
  # this rake task generates 3 fake users, and each user has 2 questions answered.
  # 5 questions (those each with 3 answers).. 

  desc "generate fake users, questions, and answers data for NormalCC project testing."
  task :uqa => :environment do #user, question, answer --> uqa

    all_years = []
    for i in 1911..2014 
      all_years.push i 
    end 

    # generate 3 users
    3.times do |n|
      User.create(email: "sample#{Random.rand(10000000)}@email.com", female: [true, false].sample, 
        birth_year: all_years.sample, country: Country.all.sample)
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
  

  desc "Create 20 fake users."
  task :create_20_users => :environment do 

    20.times do |n|
      User.create(email: "sample#{Random.rand(10000000)}@email.com", female: [true, false].sample, 
        birth_year: (1920 + Random.rand(40)), country: Country.all.sample)
      # puts params
      # User.create!(params)
    end
  end


  desc "Create a fake question and 5 answers."
  task :create_qa => :environment do 

    #  create the question
    question = Question.create(title: "What time do you go to bed?", user_id: User.first.id )

    # create answers 
    possible_answers = ["7pm", "9pm", "11pm", "1am", "3am"]

    5.times do |a|
      Answer.create(title: possible_answers[a-1], question_id: Question.first.id)
    end
  end   
 
############ RUN THIS TASK ##############
desc "Create 20 fake lines in the scorecard, depends on above two tasks"
  task :create_s => [:create_20_users, :create_qa] do 

    20.times do |a|
      the_user_id = User.first.id + a
      the_answer_id = Answer.first.id + Random.rand(5)   # only allows answer_ids within the first 5 answers
      # puts first_user_id + a
      Scorecard.create(user_id: the_user_id, answer_id: the_answer_id  )
    end
  end   

end