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
      User.create(email: "sample#{Random.rand(100)}@email.com", female: [true, false].sample, 
        birth_year: all_years.sample) # country: Country.all.sample
    end

    User.all.each do |u|
      2.times do
        u.questions.create(title: Faker::Company.bs) #, user_id: User.all.sample.id )
      end
    end

    Question.all.each do |quest|
      3.times do
        quest.answers.create(title: Faker::Lorem.sentence(3) )
      end
    end

    User.all.each do |u|
      # generate random Scorecard pairings between users and questions
      2.times do
        u.scorecards.create(answer: Answer.all.sample )
      end
    end
  end
  
  ##### RUN THIS TASK, IT WILL CALL THE LOWER TWO TASKS   ##### $ bin/rake fake_data:create_s
  desc "Create 20 fake lines in the scorecard, depends on below two tasks"
  task :create_s => [:create_20_users, :create_qa] do 

    20.times do |a|
      the_user_id = User.first.id + a
      the_answer_id = Answer.first.id + Random.rand(5)   # only allows answer_ids within the first 5 answers
      # puts first_user_id + a
      Scorecard.create!(user_id: the_user_id, answer_id: the_answer_id  )
    end
  end   

  desc "Create 20 fake users."
  task :create_20_users => :environment do 

    20.times do |n|
      User.create!( email: "sample#{Random.rand(10000000)}@email.com", 
                  birth_year: (1920 + Random.rand(40)), 
                  female: [true, false].sample, 
                  country_id: Country.first.id,
                  ip_address: "22.231.113.64",
                  # latitude: 123.55555,
                  # longitude: 123.231,
                  name: "boris#{Random.rand(10000)}",
                  password_digest: "123412342134",
                  admin: false,
                  activated: true,
                  activated_at: "Tue, 24 Feb 2015 03:44:44 UTC +00:00")
    end
  end

  desc "Create fake questions and answers."
  task :create_qa => :environment do 

    question1 = Question.create!(title: "What time do you go to bed?", user_id: User.first.id )
    possible_answers1 = ["7pm", "9pm", "11pm", "1am", "3am"]
    possible_answers1.count.times do |a|
      Answer.create!(title: possible_answers1[a-1], question_id: question1.id)
    end

    question2 = Question.create!(title: "What colour is this dress?", user_id: User.first.id )
    possible_answers2 = ["Are you serious?", "I'm going outside.", "You realise there is a massive refugee crisis in Syria?"]
    possible_answers2.count.times do |a|
      Answer.create!(title: possible_answers2[a-1], question_id: question2.id)
    end
   
    question3 = Question.create!(title: "Eating how many pieces of chocolate per day is normal?", user_id: User.first.id )
    possible_answers3 = ["Nothing", "1", "2", "3", "4", "5", "6", "There is no limit."]
    possible_answers3.count.times do |a|
      Answer.create!(title: possible_answers3[a-1], question_id: question3.id)
    end

    question4 = Question.create!(title: "How many black cardigans is normal for a girl to own?", user_id: User.first.id )
    possible_answers4 = ["0", "1", "2", "3", "4", "5", "6", "As many as she freaking wants."]
    possible_answers4.count.times do |a|
      Answer.create!(title: possible_answers4[a-1], question_id: question4.id)
    end

    question5 = Question.create!(title: "Is it good to try to patch things up between two friends?", user_id: User.first.id )
    possible_answers5 = ["No you idiot.", "Yes, but prepare to be burnt"]
    possible_answers5.count.times do |a|
      Answer.create!(title: possible_answers5[a-1], question_id: question5.id)
    end
 
    question6 = Question.create!(title: "When are you the most productive?", user_id: User.first.id )
    possible_answers6 = ["3am", "6am", "9am", "Midday", "3pm", "6pm", "9pm", "12pm"]
    possible_answers6.count.times do |a|
      Answer.create!(title: possible_answers6[a-1], question_id: question6.id)
    end
 
    question7 = Question.create!(title: "What time do you eat?", user_id: User.first.id )
    possible_answers7 = ["5pm", "6pm", "7pm", "8pm", "9pm", "10pm", "11pm", "Midnight"]
    possible_answers7.count.times do |a|
      Answer.create!(title: possible_answers7[a-1], question_id: question7.id)
    end


  end   
end