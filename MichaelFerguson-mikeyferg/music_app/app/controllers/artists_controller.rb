class ArtistsController < ApplicationController

  def index
    if params[:query].present?
      @artists = Artist.search(params[:query], page: params[:page])
    else
      @artists = Artist.all
    end

  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.create(artist_params)
    redirect_to direct_to_right_path
  end

  def show
    @artist = find_artist
    @record_label = RecordLabel.find(@artist.record_label_id)
  end

  def edit
    @artist = find_artist
  end
  def update
    @artist = find_artist
    @artist.update_attributes(artist_params)
    redirect_to artists_path
  end

  def destroy
    @artist = find_artist
    #@artist.songs.destroy
    @artist.destroy
    @songs = Song.where(:artist_id => params[:id])
    @songs.delete_all
    redirect_to artists_path
  end


  private

  def direct_to_right_path
    if params[:artist].has_key?'from_record_label_page'
      record_label_path(@artist.record_label)
    else
      artists_path
    end
  end

  def artist_params
    params.require(:artist).permit(:name, :record_label_id, :record_label)
  end

  def find_artist
    @artist = Artist.find(params[:id])
  end
end
