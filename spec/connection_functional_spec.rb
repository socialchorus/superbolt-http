require 'spec_helper'
require 'bunny'

describe Superbolt::Http::Connection, 'functional specs' do 
  let(:url) { 'http://guest:guest@localhost:15672' }

  before do
    Superbolt::Http::Connection.url = url
  end

  describe ".all" do
    it "should return the right number of connections" do
      2.times { Bunny.new.start }
      Superbolt::Http::Connection.all.count.should == 2  
    end
  end

  describe ".delete" do
    it "should reduce the connections" do
      all_connections = Superbolt::Http::Connection.all
      all_connections.each { |connection| connection.delete }

      wait_until {Superbolt::Http::Connection.all.count == 0}
    end
  end
end

def wait_until &block
  while !block.call; end
end