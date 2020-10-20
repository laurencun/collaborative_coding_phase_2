class Event < ApplicationRecord
    belongs_to :host, :class_name => :User
    belongs_to :lang_topic
    has_many :participants, :class_name => :User
    attr_reader :language, :topic

    after_save :set_host 
    before_destroy :remove_as_host 

    def remove_as_host
        if Event.where(host: host).where.not(id: id).empty?
          host.update(is_host: false)
        end
      end
    
      def set_host
        unless host.is_host?
          host.update(is_host: true)
        end
      end


    def language
        self.lang_topic.language
    end

    def topic
        self.lang_topic.topic
    end
end
