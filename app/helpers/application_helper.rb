# This is where we put helper functions to be used in our views.
# Not sure if helper functions defined here can be used in other places...


module ApplicationHelper

    # https://en.gravatar.com/
    def gravatar_for(user, options = { size: 80 })
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        size = options[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"

        # img-circle is a Bootstrap class
        # Remember: Ruby automatically returns the return value of the last line in a method
        image_tag(gravatar_url, alt: user.username, class: "img-circle")
    end

end
