# frozen_string_literal: true

RSpec.describe Application, type: :routes do
  describe 'POST /api/v1/signup' do
    context 'missing parameters' do
      let(:params) { { name: 'bob', email: 'bob@example.com', role: 'admin', password: '' } }

      it 'returns an error' do
        post 'api/v1/signup', params

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      let(:params) do
        { name: 'bob', email: 'bob@example.com', role: 'no', password: 'givemeatoken' }
      end

      it 'returns an error' do
        post 'api/v1/signup', params

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => 'must have one of the following values: ' \
              '["developer", "admin", "manager"]',
            'source' => {
              'pointer' => '/data/attributes/role'
            }
          }
        )
      end
    end

    context 'valid parameters' do
      let(:params) do
        { name: 'bob', email: 'bob@example.com', role: 'admin', password: 'givemeatoken' }
      end

      it 'returns created status' do
        post 'api/v1/signup', params

        expect(last_response.status).to eq(201)
      end
    end
  end

  describe 'POST api/v1/login' do
    context 'missing parameters' do
      let(:params) { { email: 'bob@example.com', password: '1' } }

      it 'returns an error' do
        post 'api/v1/login', params

        expect(last_response.status).to eq(401)
      end
    end

    context 'invalid parameters' do
      let(:params) { { email: 'bob@example.com', password: 'invalid' } }

      it 'returns an error' do
        post 'api/v1/login', params

        expect(last_response.status).to eq(401)
        expect(response_body['errors']).to include('detail' => 'Session can not be created')
      end
    end

    context 'valid parameters' do
      let(:token) { 'jwt_token' }
      let(:params) { { email: 'bob@example.com', password: 'givemeatoken' } }

      before do
        Fabricate(:user, email: 'bob@example.com', password: 'givemeatoken')

        allow(JWT).to receive(:encode).and_return(token)
      end

      it 'returns created status' do
        post 'api/v1/login', params

        expect(last_response.status).to eq(201)
        expect(response_body['meta']).to eq('token' => token)
      end
    end
  end
end
