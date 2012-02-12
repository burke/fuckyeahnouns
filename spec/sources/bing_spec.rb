require './sources/bing.rb'

describe 'Bing' do

  describe '.process_json' do
    subject { Bing.process_json(Bing.open_json('./spec/support/bing.json')) }
    its([:total])  { should equal 5660 }
    its([:images]) { should respond_to :each }
  end

  describe '.fetch' do
    before do
      Bing.stub(:open_json) do
        {
          "SearchResponse" => {
            "Image" => {
              "Total" => 1,
              "Results" => [{ 'MediaUrl' => 'http://example.com/example.jpg'}]
            }
          }
        }
      end

      Kernel.stub(:open) do
        open('./spec/support/test_image.jpg')
      end
    end

    let(:subject)     { Bing.fetch('xbox') }
    its(:images)      { should respond_to(:each) }
    its(:images)      { should ==(['http://example.com/example.jpg'])}

    its('best_image.path')  { should == './spec/support/test_image.jpg' }
  end

  describe 'search_url' do
    subject { Bing.search_url('xbox') }
    it { should match(/http:\/\//) }
  end
end
