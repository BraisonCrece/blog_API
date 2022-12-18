require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  # Devuelve respuesta vacía con código 200 OK para GET /posts
  describe "GET /posts" do
    before { get '/posts' }

    it "should return OK" do
      payload = JSON.parse(response.body)
      expect(payload).to be_empty
      expect(response).to have_http_status(200)
    end
  end

  describe "with data in the DB" do
    let!(:posts) { create_list(:post, 10, published: true) }

    it "should return all the published posts" do
      # Mostrar todos los posts publicados posts#index (GET /posts)
      get '/posts'
      payload = JSON.parse(response.body)
      expect(payload.size).to eq(posts.size)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /post/{id}" do
    let!(:post) { create(:post) }

    it "should return a post" do
      # Mostrar un post post#show (GET /posts/:id)
      get "/posts/#{post.id}"
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["id"]).to eq(post.id)
      expect(payload["title"]).to eq(post.title)
      expect(payload["content"]).to eq(post.content)
      expect(payload["published"]).to eq(post.published)
      expect(payload["author"]["name"]).to eq(post.user.name)
      expect(payload["author"]["email"]).to eq(post.user.email)
      expect(payload["author"]["id"]).to eq(post.user.id)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /posts" do
    let!(:user) { create(:user) }
    it "should create a post" do
      req_payload = {
        post: {
          title: "foo",
          content: "bar",
          published: false,
          user_id: user.id
        }
      }
      # Crear un post post#create (POST /posts)
      post "/posts", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["id"]).to_not be_nil
      expect(response).to have_http_status(:created)      
    end

    it "should return an error message on invalid post" do
      req_payload = {
        post: {
          content: "bar",
          published: false,
          user_id: user.id
        }
      }
      # Crear un post post#create (POST /posts)
      post "/posts", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["error"]).to_not be_nil
      expect(response).to have_http_status(:unprocessable_entity)      
    end
  end

  describe "PUT /posts/:id" do
    # creamos un post con el factory
    let!(:article) { create(:post) }

    it "should update a post" do
      # definimos el payload que vamos a enviar para actualizar el post
      req_payload = {
        post: {
          title: "foo",
          content: "bar",
          published: true          
        }
      }
      # actualizamos el post post#update (PUT /posts/:id)
      put "/posts/#{article.id}", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["id"]).to eq(article.id)
      expect(response).to have_http_status(:ok)      
    end

    it "should return an error message on invalid post" do
      req_payload = {
        post: {
          title: nil,
          content: nil,
          published: false,
        }
      }
      # actualizamos el post post#update (PUT /posts/:id)
      put "/posts/#{article.id}", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["error"]).to_not be_nil
      expect(response).to have_http_status(:unprocessable_entity)     
    end

  end
end