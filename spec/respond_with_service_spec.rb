require 'respond_with_service'

class TestRespondWithService
  include RespondWithService
end


describe RespondWithService do
  it "module class method" do
    TestRespondWithService::Toto.hello.should eql("hi")
  end

  describe 'InstanceMethods' do
    before :each do
      @test_class = TestRespondWithService.new

    end
    it "instance method" do
      @test_class.foo.should eql("bar")
    end
  end

end
