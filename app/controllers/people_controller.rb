class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /people
  # GET /people.json
  def index
    @people = Person.all
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)
    Person.transaction do
      if @person.save
        response = HTTParty.post 'http://192.168.11.92:5002/face',
                                 body: { 'FaceData' => params[:facedata],
                                         'Identify' => @person.id }.to_json,
                                 headers: { 'Content-Type' => 'application/json',
                                            'Accept' => 'application/json' }

        logger.debug"response is  #{response}"
        render json: response
        raise ActiveRecord::Rollback, "Call tech support!" unless response['returncode'] == 200
      end
    end

=begin
    respond_to do |format|
      if @person.save
        response = HTTParty.post 'http://192.168.11.92:5002/face',
                                 body: { 'FaceData' => params[:facedata],
                                         'Identify' => @person.id }.to_json,
                                 headers: { 'Content-Type' => 'application/json',
                                            'Accept' => 'application/json' }
        if response[:'ReturnCode'] == 200
          format.html { redirect_to @person, notice: 'Person was successfully created.' }
          format.json { render :show, status: :created, location: @person }
        else
          format.html { render :new }
          format.json { render json: @person.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
=end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name, :detail, :score)
    end
end
