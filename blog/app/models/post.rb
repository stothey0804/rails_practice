class Post < ActiveRecord::Base
  attr_accessible :content, :name, :title, :tags_attributes
  # 모든 Post는 name과 title을 가지고있어야 함.
  validates :name,  :presence => true
  validates :title, :presence => true,
                    :length => { :minimum => 5 } # 제목은 5글자 이상.
  has_many :comments, :dependent => :destroy
  has_many :tags

  accepts_nested_attributes_for :tags, :allow_destroy => :true,
                               :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
end
