class Publisher
    include Mongoid::Document

    field :username, type: String

    embeds_many :placements
end

