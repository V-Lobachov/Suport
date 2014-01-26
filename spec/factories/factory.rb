FactoryGirl.define do
  factory :staff do
    name 'Jon'
    email 'Jon163@gmail.com'
    password '12345678'
  end 

  factory :ticket do
    name 'Adam'
    email 'lcf111@bigmir.net'
    issue 'Error'
    body 'Not good'
  end
end 
