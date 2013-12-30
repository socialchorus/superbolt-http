require 'spec_helper'
require 'bunny'

describe Superbolt::Http::Connection, 'functional specs' do 
  let(:url) { 'http://guest:guest@localhost:15672' }

  before do
    Superbolt::Http::Connection.url = url
  end

  it ".all should return two connections" do
    Bunny.new.start
    Bunny.new.start
    expect(Superbolt::Http::Connection.all.count).to eq(2)
  end

  it ".delete should reduce the connections" do
    # all_connections = Superbolt::Http::Connection.all 
    # Superbolt::Http::Connection.delete(all_connections[0].name)
  end
end