FactoryGirl.define do
  factory :user do |u|
    u.name {FFaker::Name.name}
    u.off_day {FFaker::Time.date.split(" ")[0]}
    u.id {rand(9)}
  end

end
