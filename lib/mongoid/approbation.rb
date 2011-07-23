require 'mongoid'


module Mongoid #:nodoc:

  module Approbation
    extend ActiveSupport::Concern
    
    included do
      cattr_accessor :force_status, :options
    end
    


    module ClassMethods


      def under_approbation(*fields)
        self.options = fields.extract_options!
        self.options[:default] ||= :pending
        self.options[:save_as] ||= :pending
        
#        raise "bad mp3 encoding" if !accepted_status?(self.options[:default])
#        raise "bad mp3 encoding" if !accepted_status?(self.options[:save_as])
        
        field :approbation_status, :type => Symbol, :default => self.options[:default]
        
        before_save :update_status
      end

      # Finds the document with the specified slug or returns nil.
      def find_by_status(status)
        where(:approbation_status => status)
      end

    end

    def status
      self.approbation_status
    end

    def set_status(status)
      raise "The status #{status} is not authorised" if !accepted_status?(status)
      self.approbation_status = status
      self.force_status = true
    end
    
    def is_status(status)
      return true if (self.approbation_status == status)
      
      false
    end
    
    def save_as(status)
      raise "The status #{status} is not authorised" if !accepted_status?(status)
      self.set_status(status)
      self.save
    end
    
    private

    def update_status
      self.approbation_status = self.options[:save_as] if (self.force_status != true)
      self.force_status = false
      
      return true
    end
    
    def accepted_status?(status)
      return true if (self.options[:accepted_status] == nil)
      
      self.options[:accepted_status].each do |tmp|
        return true if (tmp == status)
      end 
      return false
    end
  end
end
