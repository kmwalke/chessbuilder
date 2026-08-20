require 'rails_helper'

RSpec.describe ApplicationHelper do
  it 'gets algebraic notation' do
    expect(helper.algebraic_notation(3, 4)).to eq('c4')
  end

  it 'gets xy notation' do
    expect(helper.xy_notation('e7')).to eq({ x: 5, y: 7 })
  end
end
