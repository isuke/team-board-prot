module UsersHelper
  def gravatar_for(user, size: 25)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar img-rounded")
  end

  def pronoun_or_name_for(user, pronoun='You')
    if current_user?(user)
      pronoun
    else
      user.name
    end
  end

end
