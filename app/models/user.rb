class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable,
         :rememberable, :trackable, :validatable,
         :lockable, :authentication_keys => [:username]
  devise :registerable if Settings.users.registerable
  devise :recoverable if Settings.users.recoverable
end
