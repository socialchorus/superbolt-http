require 'spec_helper'
require 'bunny'

describe Superbolt::Http::Connection, 'functional specs' do 
  let(:url) { 'http://guest:guest@localhost:15672' }

  before do
    Superbolt::Http::Connection.url = url
  end

  describe ".all" do
    it "should return the right number of connections" do
      10.times { Bunny.new.start }
      Superbolt::Http::Connection.all.count.should == 10  
    end
  end

  describe ".delete" do
    it "should reduce the connections" do
      all_connections = Superbolt::Http::Connection.all
      all_connections.each { |connection| connection.delete }
      sleep 5
      Superbolt::Http::Connection.all.each do |conn|
        conn.state.should == "closed"
      end
    end
  end
end