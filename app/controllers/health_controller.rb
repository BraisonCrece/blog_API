class HealthController < ApplicationController
  def health
    render json: {api: 'ok'}, status: :ok
  end
end
