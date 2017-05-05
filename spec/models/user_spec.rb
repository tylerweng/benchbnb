require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:markov) { User.create!(username: 'markov', password: 'password') }
  describe 'validations' do
    # validation tests go here
    # before(:each) do
    #   User.create!(username: 'markov', password: 'password')
    # end
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_uniqueness_of(:username) }
  end

  describe 'associations' do
    # association tests go here
    it { should have_many(:favorites)}
    it { should have_many(:favorite_benches)}
  end

  describe 'model_methods' do
    describe '.find_by_credentials' do
      context 'when given correct credentials' do
        it 'should find the right user' do
          # test goes here
          markov2 = User.find_by_credentials('markov', 'password')
          expect(markov).to eq(markov2)
        end
      end

      context 'when given incorrect credentials' do
        it 'should return nil' do
          # test goes here
          markov2 = User.find_by_credentials('markov2', 'password')
          expect(markov2).to be(nil)
        end
      end
    end
  end

  describe 'instance_methods' do
    describe '#reset_session_token!' do
      it 'resets the session token' do
        # test goes here
        markov.reset_session_token!
        old_token = markov.session_token
        new_token = markov.reset_session_token!
        expect(old_token).not_to eq(new_token)
      end
    end
  end

end
