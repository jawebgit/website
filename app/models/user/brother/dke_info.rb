class User::Brother::DkeInfo < ActiveRecord::Base
  belongs_to :brother
  belongs_to :big, class_name: "User::Brother::DkeInfo"
  has_many :littles, class_name: "User::Brother::DkeInfo", foreign_key: "big_id"
  belongs_to :residence, class_name: "Chapter::Residence"
  has_many :positions, class_name: "Chapter::Position"
  #id  int(11)
  #brother_id  int(11)
  #p_name  text
  #project   text
  #past_pos  text
  #big_id  int(11)
  #residence_id  int(11)
  #p_class   int(4)
  validates :p_class, presence: true, format: {with: /[\d]{4}/}
  #created_at  datetime
  #updated_at  datetime
  
  def initialize(params = {})
    littles = params.delete(:little_ids)
    super(params)
    assign_littles(littles)
  end
  
  def update_attributes(params)
    assign_littles(params.delete(:little_ids))
    return super(params)
  end
  
  def assign_littles(little_array)
    if little_array
      littles = []
      little_array.split(",").each do | element |
        littles << element.to_i unless element == "null"
      end
      self.little_ids = littles
    end
  end
end