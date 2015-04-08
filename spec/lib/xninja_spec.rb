require './spec/spec_helper'
require './lib/xninja'

describe 'XNinja::Client' do
  client = XNinja::Client.new
  it 'is not nill' do
    expect(client).not_to eq(nil)
  end

  it 'has some contetns ' do
    top_contents = client.top
    expect(top_contents.count > 10).to eq(true)
    expected_keys = {:title => 'hoge', :url => 'http://hogehoge.com', :thumbnail => 'hugahugahuga'}.keys
    top_contents.each do |n|
      expect(n.keys).to eq(expected_keys)
    end
  end
end
