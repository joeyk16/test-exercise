FactoryGirl.define do

  factory :user, :class => User do
		username "example" 
		email "example@example.com" 
		admin "false" 
		password_digest "<%= User.digest('password') %>"
	  activated "true"
	  activated_at "<%= Time.zone.now %>"
  end


end
