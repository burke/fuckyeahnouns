require './boot'

require './actions/noun'

describe Actions::Noun do
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

  describe "valid noun" do
    let(:subject) do
      Actions::Noun.create("sleepy")
    end

    it "runs" do
      subject.should_not be_nil
    end
  end
end
