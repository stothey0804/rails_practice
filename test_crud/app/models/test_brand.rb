# -*- encoding : utf-8 -*-
class TestBrand < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :description, :as => :model, :class_name => 'TextContent', :conditions => { :tag => TextContent::TAG_TEST_BRAND_DESCRIPTION }, :dependent => :destroy
  accepts_nested_attributes_for :description, :allow_destroy => true

  has_one :img_representative, :as => :attachable, :class_name => '::ImageFileRepresentative', :conditions => { :tag => ::ImageFileRepresentative::TAG_TEST_BRAND_REPRESENTATIVE }, :dependent => :destroy
  accepts_nested_attributes_for :img_representative, :allow_destroy => true

end
