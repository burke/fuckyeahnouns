require './sources/bing.rb'

describe 'Bing' do

  describe '.process' do
    subject { Bing.process(Bing.open_json('./spec/support/bing.json')) }
    its([:total])  { should equal 5660 }
    its([:images]) { should respond_to :each }
  end

  describe '.fetch' do
    before(:all) do
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
        File.new('./spec/support/test_image.jpg')
      end
    end
    let(:subject)  { Bing.fetch('xbox') }
    it { should respond_to(:read) }
  end

  describe 'search_url' do
    subject { Bing.search_url('xbox') }
    it { should match(/http:\/\//) }
  end
end
