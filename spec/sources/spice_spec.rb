require './sources/spice.rb'

describe 'Spice' do
  describe '.up' do
    subject do
      Spice.up('apple')
    end

    it { should_not be_nil }
  end

  describe '.replace' do
    subject do
      Spice.replace('apple',['orange'])
    end

    it { should == 'orange' }
  end

  describe '.prefix' do
    subject do
      Spice.prefix('apple',['orange'])
    end

    it { should == 'orange apple' }
  end

  describe '.suffix' do
    subject do
      Spice.suffix('apple',['orange'])
    end

    it { should == 'apple orange' }
  end
end
