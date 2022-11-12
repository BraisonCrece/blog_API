require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /post' do
    before { get '/post' }

    it 'returns a OK' do
      payload = JSON.parse(response.body)
      expect(payload).to be_empty
      expect(response).to have_http_status(200)
    end

    describe 'with data in the DB' do
      # let, método interno de RSpec para definir variables
      # create_list => Método de FactoryBot para crear listas de instancias
      let(:posts) { create_list(:post, 10, published: ture) }

      payload = JSON.parse(response.body)
      expect(payload.size).to       eq(posts.size)
      expect(response).to           have_http_status(200)


      it 'returns all the published posts' do
        payload = JSON.parse(response.body)
      
      end
    end
  end



  decribe 'GET /post/:id' do

  end
end