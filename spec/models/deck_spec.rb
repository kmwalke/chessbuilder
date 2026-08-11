require 'rails_helper'

RSpec.describe Deck do
  it 'requires a name' do
    expect(described_class.create(name: '').errors).to have_key(:name)
  end
end
