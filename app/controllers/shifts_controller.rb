class ShiftsController < ApplicationController
  before_action :logged_in_user, :set_shift, only: [:show, :edit, :update, :destroy]

  # GET /shifts
  # GET /shifts.json
  def index
    @shifts = Shift.all
    @shift = Shift.new
    @emplList = User.all
  end

  # GET /shifts/1
  # GET /shifts/1.json
  def show
  end

  # GET /shifts/new
  def new
    @shift = Shift.new
    @emplList = User.all
  end

  # GET /shifts/1/edit
  def edit
  end

  # POST /shifts
  # POST /shifts.json
  def create
    name = User.where(email: "#{shift_params['user_id']}").take
    shift = Shift.new(shift_params)
    session[:selected] = shift_params['user_id']
    #Editing the end time to match the start times day, month, and year
    shift.end_time = shift.end_time.change(day: shift.start_time.strftime('%d'))
    shift.end_time = shift.end_time.change(month: shift.start_time.strftime('%m'))
    shift.end_time = shift.end_time.change(year: shift.start_time.strftime('%Y'))
    shift.name = name.name
    respond_to do |format|
      if shift.save
        flash[:success] = "Successfully created shift #{}"
        format.html { redirect_to action: "index" }
        # format.json { render :show, status: :created, location: @shift }
      else
        format.html { render :new }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shifts/1
  # PATCH/PUT /shifts/1.json
  def update
    respond_to do |format|
      if @shift.update(shift_params)
        format.html { redirect_to @shift, notice: 'Shift was successfully updated.' }
        format.json { render :show, status: :ok, location: @shift }
      else
        format.html { render :edit }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shifts/1
  # DELETE /shifts/1.json
  def destroy
    if session[:user_privs] == 'manager'
      @shift.destroy
      respond_to do |format|
        format.html { redirect_to shifts_url, notice: 'Shift was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to shifts_url, notice: 'Cannot destroy shift'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shift
      @shift = Shift.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shift_params
      params.require(:shift).permit(:user_id, :start_time, :end_time)
    end

    def set_selected
      @selected = User.find(params[:user_id])
    end

    def logged_in_user
      unless session[:user_id]
        redirect_to root_path
      end
    end
end
