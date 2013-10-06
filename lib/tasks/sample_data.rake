namespace :db do
    desc "Fill database with fake stuff"
    task :populate => :environment do
        99.times do |n|
            title = Faker::Lorem.words.join(" ")
            description = Faker::Lorem.paragraph
            credits = (1..5).to_a.sample
            Event.create!(title: title, description: description, credits: credits)
        end
    end
end

