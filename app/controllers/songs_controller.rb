class SongsController < ApplicationController
  before_filter :get_artist
  def get_artist
    @artist = Artist.find(params[:artist_id])
  end
  # GET /songs
  # GET /songs.json
  def index
    # @songs = Song.find_by_artist_id params[:artist_id]
    @songs = Song.find_all_by_artist_id params[:artist_id]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @songs }
    end
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    @song = Song.find(params[:id])
    @yt_id = YoutubeSearch.search("#{@song.name} #{@song.artist.name}").first['video_id']

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @song }
    end
  end

  # GET /songs/new
  # GET /songs/new.json
  def new
    @song = Song.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @song }
    end
  end

  # GET /songs/1/edit
  def edit
    @song = Song.find(params[:id])
  end

  # POST /songs
  # POST /songs.json
  def create
    # Hack? How to do this better...
    params[:song][:genre] = Genre.find(params[:song][:genre_id])
    params[:song].delete(:genre_id)
    params[:song][:artist] = @artist
    @song = Song.new(params[:song])

    respond_to do |format|
      if @song.save
        format.html { redirect_to [@artist, @song], notice: 'Song was successfully created.' }
        format.json { render json: @song, status: :created, location: @song }
      else
        format.html { render action: "new" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /songs/1
  # PUT /songs/1.json
  def update
    @song = Song.find(params[:id])
    # Hack? How to do this better...
    params[:song][:genre] = Genre.find(params[:song][:genre_id])
    params[:song].delete(:genre_id)

    respond_to do |format|
      if @song.update_attributes(params[:song])
        format.html { redirect_to [@artist, @song], notice: 'Song was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song = Song.find(params[:id])
    @song.destroy

    respond_to do |format|
      format.html { redirect_to songs_url }
      format.json { head :no_content }
    end
  end
end
