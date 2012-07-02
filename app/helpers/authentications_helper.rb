module AuthenticationsHelper
  def login_path
  	if Rails.env.production?
    	href="http://hungryfeedme.herokuapp.com/auth/twitter"
    else
    	href="http://lvh.me:3000/auth/twitter"
    end
  end
end
