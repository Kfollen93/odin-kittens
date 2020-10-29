class KittensController < ApplicationController
  def new
    @kitten = Kitten.new
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      flash[:notice] = "A cute kitten has been created!"
      redirect_to kitten_path(@kitten)
    else
      render :new
    end
  end

  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html
      format.json { render :json => @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @kitten }
    end
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      flash.notice = "'#{@kitten.name}' has been updated!'"
      redirect_to kitten_path
    else
      render :edit
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy
    flash.notice = "'#{@kitten.name}' has been let go!"
    redirect_to kittens_path
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end

end