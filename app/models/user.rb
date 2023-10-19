class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

	has_many :submissions

	devise :database_authenticatable, :registerable,
				:recoverable, :rememberable, :validatable
	validates :username, format: { without: /\s/ }, uniqueness: true
end
