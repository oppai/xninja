require './spec/spec_helper'
require './lib/xninja'

describe 'XNinja::Client' do
  client = XNinja::Client.new
  it 'is not nil' do
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

  it 'get detail videos' do
    video  = client.top.first
    detail = client.detail(video[:url])
    expect(detail).not_to eq(nil)
    expect(detail[:high].class).to eq(String)
    expect(detail[:low].class).to eq(String)
    expect(detail[:thumbnail].class).to eq(String)
    expect(detail[:title].class).to eq(String)
  end
end
