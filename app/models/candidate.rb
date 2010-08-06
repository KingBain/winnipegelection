class Candidate < ActiveRecord::Base
  extend Random
  
  belongs_to :ward
  
  has_many :mentions, :dependent => :destroy
  has_many :news_articles, :through => :mentions
  has_many :approved_articles, :through => :mentions, :source => :news_article, :conditions => "news_articles.moderation ='approved'"
  
  validates_presence_of :name, :ward_id
  
  attr_accessible :name, :ward_id, :incumbent_since, :website, :facebook, :twitter, :youtube, :office_address, :phone_number, :email, :image_url, :dob, :image, :delete_image, :majorissues
  
  has_attached_file :image, :styles => { :medium => "300x300>", :small => "200x200>", :thumb => "100x100>" },
                    :url  => "/uploads/candidate_image/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/uploads/candidate_image/:id/:style/:basename.:extension"
  
  named_scope :with_approved_articles, :include => :news_articles, :conditions => "news_articles.moderation ='approved'"
    
  # Virtual Attribute for image deletion.
  def delete_image=(value)
    self.image = nil if (!value.to_i.zero?)
  end
  
  def delete_image
    false
  end
  
end
