require 'spec_helper'

require 'gnunet/services/dht/put_response_msg'

describe Gnunet::Services::Dht::PutResponseMsg do
  it "should unpack" do
    put_response=Gnunet::Services::Dht::PutResponseMsg.unpack([1111,2222,3333,4444].pack("nnNQ"))
    put_response.size.should == 1111
    put_response.type.should == 2222
    put_response.reserved.should == 3333
    put_response.unique_id.should == 4444
  end

end

