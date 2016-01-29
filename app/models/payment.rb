class Payment < ActiveRecord::Base
   belongs_to :service
   belongs_to :line_item
end
