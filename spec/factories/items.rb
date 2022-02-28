FactoryBot.define do
  factory :item do
    content { "MyString" }
    status { false }
    todo { nil }
  end
end
