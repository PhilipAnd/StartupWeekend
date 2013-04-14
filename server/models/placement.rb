class Placement
    include Mongoid::Document

    field :height, type: Integer
    field :width, type: Integer
    field :advertiser_rejects, type: Array
    field :advertiser_approves, type: Array
    field :advertisements_rejects, type: Array
    field :advertisements_approves, type: Array

    embedded_in :publisher, :inverse_of => :placements
   # has_many :advertisements
end


