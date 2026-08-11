require 'rails_helper'

RSpec.describe Game do
  it 'displays a name' do
    game = create(:game)

    expect(game.name).to eq("#{game.host.name} VS #{game.guest.name}")
  end
end
