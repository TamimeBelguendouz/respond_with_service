require 'respond_with_service'

describe RespondWithService do
  it "broccoli is gross" do
    puts 'laal'
    puts RespondWithService.inspect
    puts RespondWithService.methods
    puts 'laal'
    RespondWithService::Toto.hello.should eql("hi")
  end

end
