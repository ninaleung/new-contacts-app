class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :grouped_contacts
  has_many :groups, through: :grouped_contacts

  def readable_updated_on
    updated_at.strftime("%A, %d %b %Y at %l:%M %p")    
  end

  def full_name
    first_name + " " + last_name
  end

  def japanese_prefix
    "+81" + " " + phone
  end
end
