FactoryBot.define do
  factory :follow do
    follower_id { 1 }
    followed_user_id { 1 }
  end
end
