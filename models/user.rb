# En models/user.rb
require_relative '../database'

class User < Sequel::Model(:users)
end