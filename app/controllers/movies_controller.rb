class MoviesController < ApplicationController
before_action :authenticate_user!


  def index
  	@movies = Movie.all 
  end

  def search
  	@search = params[:query]

  	#@shirt = Tshirt.all.find { |shirt| shirt.name.downcase.include? @search }
  	#on the below - percentage means anything that matches that search item. 
  	@movie = Movie.search(@search) 
  	#the exclamation mark below is a bang, it restructures. 
  	@no_results = !@movie
  end

  def new
  	@movie = Movie.new
  end 

  def create
  	@movie = Movie.new(parameters)
    #the bang at the end of save below is there because without the bang then it would only return true or false. 
  	if @movie.valid? 
      @movie.save
      flash.now[:info] = 'You have created a Movie'
      redirect_to root_path
    else
      flash[:error] = "You have an error"
    end
  end 

  private
  def parameters
  	params.require(:movie).permit(:name, :description)
  end 

end
