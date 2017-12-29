class FaceController < ApplicationController
  skip_before_action :verify_authenticity_token
  def recognize
    response = HTTParty.post 'http://192.168.11.92:5002/recognize',
                             body: { 'FaceData' => params[:FaceData] }.to_json,
                             headers: { 'Content-Type' => 'application/json',
                                        'Accept' => 'application/json' }
    render json: response
  end
end
