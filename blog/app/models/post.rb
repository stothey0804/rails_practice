class Post < ActiveRecord::Base
  attr_accessible :content, :name, :title
  # 모든 Post는 name과 title을 가지고있어야 함.
  validates :name,  :presence => true
  validates :title, :presence => true,
                    :length => { :minimum => 5 } # 제목은 5글자 이상.
  has_many :comments
end
