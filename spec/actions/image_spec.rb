require './actions/image'

describe Actions::Image do

  describe '.create' do
    def image(name)
      Actions::Image.create(name)
    end

    def test_image
      File.new('spec/support/test_image.jpg')
    end
    context 'everything works' do
      before(:each) do
        Actions::Image.stub(:annotate) { test_image }
        Actions::Image.stub(:fetch)    { test_image }
      end

      let(:subject) { image("sleepy") }

      its('file.path') { should_not match(/didntfindshit/) }
    end

    context 'fetch failed' do
      before(:each) do
        Actions::Image.stub(:annotate) { test_image }
        Actions::Image.stub(:fetch)    { raise 'fetch failed' }
      end

      let(:subject) { image('sleepy') }
      its('file.path') { should match(/didntfindshit/) }

    end
    context 'annotation failed' do
      before(:each) do
        Actions::Image.stub(:annotate) { raise 'explosions' }
        Actions::Image.stub(:fetch)    { test_image }
      end

      it 'raises ' do
        expect {
          image('sleepy')
        }.to raise_error Actions::Image::AnnotationException
      end
    end

    context 'annotation success' do
      before(:each) do
        Actions::Image.stub(:fetch)    { test_image }
      end

      it 'succeeds ' do
        expect {
          image('sleepy')
        }.to_not raise_error
      end

      it 'has a file' do
        image('sleepy').file.path.should_not be_empty
      end
    end
  end
end
