class Post < ActiveRecord::Base
  validates :permalink, format: { with: /\A[A-Za-z0-9\-\._~%]+\z/ }

  before_validation if: -> { self.permalink.blank? } do
    self.permalink = self.to_hash
  end

  def to_hash
    Digest::SHA256.new.digest(self.title.to_s).unpack("C*").map do |x|
      sprintf("%x", x )
    end.join
  end
end
