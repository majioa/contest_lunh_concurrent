require 'rails_helper'

RSpec.describe Post, type: :model do
  it { expect(subject).to have_db_column(:title).of_type(:string) }
end
