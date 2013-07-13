require 'spec_helper'

require 'gnunet/services/dht/put_msg'
describe Gnunet::Services::Dht::PutMsg do
  it "should pack" do
    put=Gnunet::Services::Dht::PutMsg.new(:options => 0, :desired_replication_level => 3, :unique_id => 3434, :expiration => 0, :key => 'a'*64,
                       :data => "help!")
    put.pack.should == "\000e\000\216\000\000\000\b\000\000\000\000\000\000\000\003j\r\000\000\000\000\000\000\000\000\000\000\000\000\000\000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaahelp!"

  end

end

