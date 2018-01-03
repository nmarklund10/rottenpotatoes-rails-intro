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
    @all_ratings = Movie.all_ratings
    
    if (params[:ratings].nil? || params[:str].nil?)
      if (params[:ratings].nil?)
        @ratings_param = session[:ratings]
      else
        @ratings_param = params[:ratings]
      end
      if (params[:str].nil?)
        @str_param = session[:str]
      else
        @str_param = params[:str]
      end
      redirect_to movies_path, :str => str_param, :ratings =>ratings_param
    end
    if (!params[:ratings].nil?)
      session[:checked_ratings] = params[:ratings].keys
    end
    @ratings_checked = session[:checked_ratings]
    @displayed_movies = Movie.where({ rating: @ratings_checked})
    if (!params[:str].nil?)
      session[:str] = params[:str]
    end
    @ordering = session[:str]
    if (@ordering == "movie")
      @movies = @displayed_movies.order(:title)
    elsif (@ordering == "release")
      @movies = @displayed_movies.order(:release_date)
    else
      @movies = @displayed_movies
    end
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

end
