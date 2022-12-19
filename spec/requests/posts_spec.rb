require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  # return empty response with 200 status code
  describe "GET /posts" do
    it "should return OK" do
      get '/posts'
      payload = JSON.parse(response.body)
      expect(payload).to be_empty
      expect(response).to have_http_status(200)
    end

    describe "Search" do
      let!(:hola_mundo) { create(:published_post, title: 'Hola Mundo') }
      let!(:hola_rails) { create(:published_post, title: 'Hola Rails') }
      let!(:curso_rails) { create(:published_post, title: 'Curso Rails') }
      it "should filter posts by title" do
        get "/posts?search=Hola"
        payload = JSON.parse(response.body)
        expect(payload).to_not be_empty
        expect(payload.size).to eq(2)
        expect(payload.map { |p| p["id"] }.sort).to eq([hola_mundo.id, hola_rails.id])
        expect(response).to have_http_status(200)
      end
    end

  end

  describe "with data in the DB" do
    let!(:posts) { create_list(:post, 10, published: true) }

    it "should return all the published posts" do
      # Show all posts post#index (GET /posts)
      get '/posts'
      payload = JSON.parse(response.body)
      expect(payload.size).to eq(posts.size)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /post/{id}" do
    let!(:post) { create(:post) }

    it "should return a post" do
      # Show a post post#show (GET /posts/:id)
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
      # Create a post post#create (POST /posts)
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
      # Create a post post#create (POST /posts)
      post "/posts", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["error"]).to_not be_nil
      expect(response).to have_http_status(:unprocessable_entity)      
    end
  end

  describe "PUT /posts/:id" do
    # Create a post with factory bot
    let!(:article) { create(:post) }

    it "should update a post" do
      # we define the payload that we are going to send to update the post
      req_payload = {
        post: {
          title: "foo",
          content: "bar",
          published: true          
        }
      }
      # update the post post#update (PUT /posts/:id)
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
      # update the post post#update (PUT /posts/:id)
      put "/posts/#{article.id}", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["error"]).to_not be_nil
      expect(response).to have_http_status(:unprocessable_entity)     
    end

  end
end