class Advertiser
    include Mongoid::Document

    field :username, type: String
    field :description, type: String
    field :website, type: String
    field :img_url, type: String
    field :klout_score, type: Integer


    has_many :advertisements
end


