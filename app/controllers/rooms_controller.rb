class RoomsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json, :html
  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = current_user.rooms

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rooms }
    end
  end

  # GET /rooms/:token
  # GET /rooms/:token.json
  def show
    @room = Room.find_by_token(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @room }
    end
  end

  def join
    @room = Room.where(token: params[:token])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @room }
    end
  end

  def get_token
    api_key = Settings.opentok.api_key
    api_secret = Settings.opentok.api_secret

    opentok = OpenTok::OpenTokSDK.new api_key, api_secret
    session = opentok.create_session request.remote_addr

    token = opentok.generate_token :session_id => session, :role => OpenTok::RoleConstants::PUBLISHER, :connection_data => "username=#{current_user.email}"
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: token }
    end
  end

  def add_message
    require 'pusher'

    Pusher.app_id = '11733'
    Pusher.key = '29bf925ddf5d74c2f83f'
    Pusher.secret = '0369c29389469fc0540a'

    Pusher["public-chat-#{params[:id]}"].trigger('new_message', 
      {sender: params[:sender], message: params[:message]}, params[:socket_id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { head :no_content }
    end
  end

  # GET /rooms/new
  # GET /rooms/new.json
  def new
    @room = Room.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @room }
    end
  end

  # GET /rooms/1/edit
  def edit
    @room = Room.find(params[:id])
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = current_user.rooms.new(params[:room])
    api_key = Settings.opentok.api_key
    api_secret = Settings.opentok.api_secret

    opentok = OpenTok::OpenTokSDK.new api_key, api_secret 
    session_properties = {OpenTok::SessionPropertyConstants::P2P_PREFERENCE => "disabled"}
    session = opentok.create_session request.remote_addr, session_properties

    @room[:session_id] = session.session_id

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render json: @room, status: :created, location: @room }
      else
        format.html { render action: "new" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rooms/1
  # PUT /rooms/1.json
  def update
    @room = Room.find(params[:id])

    respond_to do |format|
      if @room.update_attributes(params[:room])
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room = Room.find(params[:id])
    @room.destroy

    respond_to do |format|
      format.html { redirect_to rooms_url }
      format.json { head :no_content }
    end
  end
end
