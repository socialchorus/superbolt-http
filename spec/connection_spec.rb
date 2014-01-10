require 'spec_helper'
require 'bunny'

describe Superbolt::Http::Connection do
  let(:url) { 'http://guest:guest@localhost:15672' }
  let(:single_connection) { "{\"name\": \"somename\"}" }
  let(:multiple_connections) { "[ {\"name\": \"firstconnection\"} ]" }

  describe '.all' do
    let(:connections) { Superbolt::Http::Connection.all }

    context 'when a url is not defined' do
      before do
        Superbolt::Http::Connection.url = nil
      end

      it "should raise an error" do
        expect { connections }.to raise_error(Superbolt::Http::Connection::NoConnectionUrl)
      end
    end

    context 'when a url is defined' do
      before do
        Superbolt::Http::Connection.url = url
        RestClient.should_receive(:get)
          .with("http://guest:guest@localhost:15672/api/connections")
          .and_return(multiple_connections)
      end

      it 'returns an array of connection elements wrapped with Superbolt::Http::Connection' do
        connections.should be_a Array
        connections.first.should be_a Superbolt::Http::Connection
      end

      it "returns a list of all open connections with the right content" do
        connections[0].name.should == "firstconnection"
        connections[0].should be_an_instance_of(Superbolt::Http::Connection)
      end
    end
  end

  describe '#delete' do
    let(:delete_connection) { connection.delete }

    context 'when a url is not defined' do
      let(:connection) { Superbolt::Http::Connection.new({"name" => "somename"}) }
      before do
        Superbolt::Http::Connection.url = nil
      end

      it "should raise an error" do
        expect { delete_connection }.to raise_error(Superbolt::Http::Connection::NoConnectionUrl)
      end
    end

    context "when a url is defined" do
      let(:delete_connection) { connection.delete }
      let(:connection) { 
        puts "url: #{Superbolt::Http::Connection.url}"
        Superbolt::Http::Connection.new({"name" => "somename"}) }
      
      before do
        Superbolt::Http::Connection.url = url
      end
      
      it 'sends a delete request to the right url' do
        RestClient.should_receive(:delete)
          .with("http://guest:guest@localhost:15672/api/connections/somename")
        delete_connection
      end
    end
  end
end