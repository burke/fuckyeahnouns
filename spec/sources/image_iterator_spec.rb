require './sources/image_iterator'

class Dummy
  include ImageIterator
  attr_accessor :images

  def initialize(images=[])
    @images = images
  end
end

describe 'ImageIterator' do
  before do
    Kernel.stub(:open) { |arg| arg }
  end

  let(:a) { stub(content_type: 'image') }
  let(:b) { stub(content_type: 'image') }
  let(:c) { stub(content_type: 'image') }

  context 'all valid images' do

    subject {  Dummy.new([a,b,c]) }

    it 'iterates as expected' do
      subject.next.should == a
      subject.next.should == b
      subject.next.should == c
      expect {
        subject.next
      }.to raise_error StopIteration
    end
  end

  context 'one in-valid image' do

    let(:c) { stub(content_type: 'text') }

    subject {  Dummy.new([a,b,c]) }

    it 'iterates as expected' do
      subject.next.should == a
      subject.next.should == b
      expect {
        subject.next
      }.to raise_error StopIteration
    end
  end
end
