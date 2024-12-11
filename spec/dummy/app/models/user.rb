class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  def to_combobox_display
    email
  end

  def inner_plan_avatar_url
    hash = Digest::SHA256.hexdigest(email.downcase)
    "https://gravatar.com/avatar/#{hash}?s=100&default=mp"
  end

  def inner_plan_to_s
    email.split('@').first
  end
end
