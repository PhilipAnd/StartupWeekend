class Advertisement
    include Mongoid::Document

    field :width, type: Integer
    field :height, type: Integer
		field :creative, type: String
		

    belongs_to :advertiser
end


