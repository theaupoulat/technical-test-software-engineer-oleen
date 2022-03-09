require 'rails_helper'
require 'services/user'

RSpec.describe Pretto::V1::UserService::ServiceImpl do
  let(:service) { described_class.new }

  describe '#fetchAll' do
    let(:request) { Pretto::V1::FetchAllRequest.new }

    subject { service.fetch_all(request) }

    context 'when there are no users' do
      it do
        is_expected.to eq(
          Pretto::V1::FetchAllResponse.new(
            users: []
          )
        )
      end
    end

    context 'with users' do
      after {
        User.all.each(&:destroy!)
      }

      let!(:user) do
        User.create!(username: 'first user', email: 'first.user@domain.tld')
      end

      it do
        is_expected.to eq(
          Pretto::V1::FetchAllResponse.new(
            users: [
              {
                id: 1,
                username: 'first user',
                email: 'first.user@domain.tld',
                created_at: DateTimeToGoogleProtobufTimestamp.call(user.created_at)
              }
            ]
          )
        )
      end
    end
  end
end
