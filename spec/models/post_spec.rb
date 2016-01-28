require 'rails_helper'

RSpec.describe Post, type: :model do
  it { expect(subject).to have_db_column(:title).of_type(:string) }

  it { expect(subject).to have_db_column(:permalink).of_type(:string).with_options(null: false, default: '') }
  it { expect(subject).to have_db_index(:permalink).unique(true) }

  describe "Post permalink" do
    context "is like a title" do
      def hex(value)
        Digest::SHA256.new.digest(value).unpack("C*").map do |x|
          sprintf("%x", x )
        end
      end
      
      subject { FactoryGirl.create :post, title: "Title", permalink: '' }

      it { expect(subject.reload.permalink).to match(/^[A-Za-z0-9\-\._~%]+$/) }
    end
  end

end
