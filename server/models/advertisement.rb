class Advertisement
    include Mongoid::Document

    field :width, type: Integer
    field :height, type: Integer
		field :creative, type: String
		field :img_url, type: String
		field :description, type: String

    belongs_to :advertiser
end


