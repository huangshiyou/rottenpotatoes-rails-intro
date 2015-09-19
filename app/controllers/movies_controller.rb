class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    sort = params[:sort] 
    case sort
    when 'title'
      #ordering, @title_header = {:order => :title}, 'hilite'
      key = 'title'
      @title_header = 'hilite'
    when 'release_date'
      #ordering, @date_header = {:order => :release_date}, 'hilite'
      key = 'release_date'   
      @date_header = 'hilite' 
    end
    #@movies = Movie.order('title').all
    @movies = Movie.order(key).all
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  #methods added
  def sort_by_titles
    @movies = Movie.order('title').all
    #restrict_to movies_sort_by_titles
  end

end
