require 'rails_helper'

RSpec.describe Game do
  it 'displays a name' do
    game = create(:game)

    expect(game.name).to eq("#{game.host.name} VS #{game.guest.name} - #{game.created_at.to_fs(:long_ordinal)}")
  end
end
