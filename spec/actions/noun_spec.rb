require './boot'

require './actions/noun'

describe Actions::Noun do
  context"valid noun" do
    let(:subject) do
      Actions::Noun.create("sleepy")
    end

    it('runs') { should_not be_nil }
    xit(:shirt) { should be_valid }

    xit('image.file') { should_not match(/didntfindshit/) }

  end

  context"nsfw noun" do
    let(:subject) do
      Actions::Noun.create("boob")
    end

    it "runs" do
      should_not be_nil
    end
    xit ('shirt.url') { should match('')}
    xit ('image.file') { should match(/didntfindshit/) }
  end
end

describe Actions::Noun::BlackListed do
  describe '.blacklisted?' do
    let(:subject) { Actions::Noun::BlackListed }

    context 'blacklisted' do
      it 'is true' do
        subject.blacklisted?('selinaferguson').should be_true
      end
    end

    context 'not blacklisted' do
      it 'is false' do
        subject.blacklisted?('sleepy').should be_false
      end
    end
  end
end

describe Actions::Noun::NSFW do
  describe '.nsfw?' do
    let(:subject) { Actions::Noun::NSFW }
    context 'is nsfw' do
      it 'is true' do
        subject.nsfw?('boob').should be_true
      end
    end

    context 'is not nsfw' do
      it 'is false' do
        subject.nsfw?('sleepy').should be_false
      end
    end
  end
end

