require './spec/spec_helper'
require './lib/xninja'

describe 'XNinja::Client' do
  it 'is not nill' do
    client = XNinja::Client.new
    expect(client).not_to eq(nil)
  end
end
