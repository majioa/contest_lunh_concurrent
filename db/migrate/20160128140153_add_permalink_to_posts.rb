class AddPermalinkToPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.string :permalink, null: false, default: ''

      t.index :permalink, unique: true
    end

    reversible do |dir|
      dir.up do
        Post.all.each { |post| post.update_attributes(permalink: post.to_slug) }
      end
    end
  end
end
