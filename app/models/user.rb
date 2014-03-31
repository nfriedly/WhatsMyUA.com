class User < ActiveRecord::Base
    include SimplestAuth::Model
    before_create :hash_password
    authenticate_by :username
end
