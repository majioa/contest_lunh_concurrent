require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { expect(subject).to have_db_column(:service_id).of_type(:integer) }
  it { expect(subject).to belong_to(:service) }

  it { expect(subject).to have_db_column(:line_item_id).of_type(:integer) }
  it { expect(subject).to belong_to(:line_item) }
end
