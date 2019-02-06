FactoryBot.define do
  factory :locker do
    is_available { false }
    name { "MyString" }
  end
end
