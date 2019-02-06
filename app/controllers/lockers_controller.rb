class LockersController < ApplicationController
  before_action :set_locker, only: [:show, :edit, :update, :destroy]

  def index
    # 1. get available lockers. to do: refactor
    @small = Locker.where(size: 'small', is_available: true).first
    @medium = Locker.where(size: 'medium', is_available: true).first
    @large = Locker.where(size: 'large', is_available: true).first

    # 6. get the requested locker with that ticket name
    # yikes, hello SQL injection!
    # we could do a Locker.where("name like ?", "#{params[:name]}%") here so that you only have to enter the first [x] number of matching characters, but the exact match here ensures you don't get a wrong locker by accident. And on second thought, coupled with unique names, that's actually a nice security feature. Someone would have to guess a case sensitive 3 word name correctly to find a used locker. I'll keep it that way.
    # (to do: generate a new unique name for each print, save it to the record, then delete it when bags are returned.)
    @search_result = Locker.where(name: params[:name]).first
  
  end

  def concierge
    #find the first available locker. to do: google how to have sql sort by 2 fields
    @lockers = Locker.all.order(size: :desc, name: :asc)
  end
  def show
  end

  def new
    @locker = Locker.new
  end

  def edit
  end

  def create
    @locker = Locker.new(locker_params)

    respond_to do |format|
      if @locker.save
        format.html { redirect_to @locker, notice: 'Locker was successfully created.' }
        format.json { render :show, status: :created, location: @locker }
      else
        format.html { render :new }
        format.json { render json: @locker.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @locker.update(locker_params)
        format.html { redirect_to @locker, notice: 'Locker was successfully updated.' }
        format.json { render :show, status: :ok, location: @locker }
      else
        format.html { render :edit }
        format.json { render json: @locker.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @locker.destroy
    respond_to do |format|
      format.html { redirect_to lockers_url, notice: 'Locker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_locker
      @locker = Locker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def locker_params
      params.require(:locker).permit(:is_available, :name, :size)
    end
end
