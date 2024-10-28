class Comment < ApplicationRecord
  belongs_to :prototype  # prototypesテーブルとのアソシエーション
  belongs_to :user  # usersテーブルとのアソシエーション
  validates :content, presence: true
end
