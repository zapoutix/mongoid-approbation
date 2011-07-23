class Book
  include Mongoid::Document
  include Mongoid::Approbation
  
  
  
  field :title
  
  under_approbation :default => :pending, :save_as => :pending, :accepted_status => [:pending, :accepted, :rejected]

end
