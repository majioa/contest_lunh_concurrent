require 'rails_helper'

load 'db/migrate/20160128140153_add_permalink_to_posts.rb'

RSpec.describe AddPermalinkToPosts, type: :migration do
  describe 'Add permalink to posts table migration' do
    before do
      @my_migration_version = '20160128140153'
      @previous_migration_version = '20160128133846'
    end

    context "fills permalinks to all posts" do
      before do
        ActiveRecord::Migrator.migrate @previous_migration_version
        @post = FactoryGirl.create :post
        AddPermalinkToPosts.up 
      end

      it { expect { Post.reset_column_information }.to change { Post.columns } }
      it { expect(Post.columns.map(&:name)).to include("permalink") }
      it { expect(Post.first.reload.permalink).to match(/\A[A-Za-z0-9\-\._~%]+\z/) }
    end
  end
end
