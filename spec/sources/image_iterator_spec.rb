require './sources/image_iterator'

describe 'ImageIterator' do
  context 'basic' do
    before do
      Kernel.stub(:open) { |arg| arg }
    end

    subject {  ImageIterator.new([:a,:b,:c]) }

    it 'iterates as expected' do
      subject.next.should == :a
      subject.next.should == :b
      subject.next.should == :c
      expect {
        subject.next
      }.to raise_error StopIteration
    end
  end
end
