class PunchiesController < ApplicationController
  before_action :set_punchy, only: [:show, :edit, :update, :destroy]

  # GET /punchies
  # GET /punchies.json
  def index
    @punchies = Punchy.where.not(timePunchIn: nil)
    dt = DateTime.now
    boy = dt.beginning_of_year
    eoy = dt.end_of_year
    @punchy = Punchy.new
  end

  # GET /punchies/1
  # GET /punchies/1.json
  def show
  end

  # GET /punchies/new
  def new
    @punchy = Punchy.new
  end

  # GET /punchies/1/edit
  def edit
  end

  # POST /punchies
  # POST /punchies.json
  def create
    #Grab the user that is punching in
    user = User.where(email: "#{punchy_params['user_id']}").take

    if not user
      flash[:error] = "Please enter a valid email."
      redirect_to action: "index"
      return
    end

    # Get the shifts for that user
    # One issue I ran into was i had no real way to get shifts off their date unless
    # there is a way and im just stupid.

    # Well, in order to punch in and out using a single textbox like most punchclocks, 
    # this makes some sense. We want to make sure we can compare shifts of *this date*, not including time,
    # which, unforch, we use DateTime for start_time and end_time
    user_shifts = Shift.where(user_id: "#{punchy_params['user_id']}").all

    # Start filling out punch information like users email and name
    @punchy = Punchy.new
    @punchy.user_id = user.email
    @punchy.name = user.name
    

    # This section does a bunch of condition checking and it can probably be done better...
    # We start first by checking if a punch exists for 'todays shift' at all.
    #   1. Loop through all the users shifts that exist.
    #   2. Loop through punches that exists.
    #   3. Check if the user_id matches, then checks if timePunchIn exists and is populated.
    #   4. Compare to todays date
    #   5. If it is the same day, and the current time is greater or equal to the punch out time, then
    #      we update the punch with the time punched out at, and redirect
    #   6. If the time punched out at is less than the required time, punch out, but only update
    #      the status to include a message saying when the user punched out, so management can track it.
    #
    # If these conditions aren't met, that then means the user hasn't punched in yet.
    # We then stay inside the 'user_shifts.each' loop and continue...
    #
    # To verify punch
    #   1. Stay in 'user_shifts.each' loop
    #   2. Compare the shifts start date to todays Date
    #   3. If so, we populate the new punches timePunchIn and timePunchOut, and status
    #   4. If not, do nothing (need to fix)
    #   5. Create punch in
    user_shifts.each do |shift|
      Punchy.all.each do |p|
        if p.user_id == user.email
          if p.timePunchIn
            if p.timePunchIn.to_date.strftime("%Y-%m-%d") == Date.today.strftime("%Y-%m-%d")
              
              if Time.now.strftime("%H-%M") >= p.timePunchOut.to_time.strftime("%H-%M")
                p.update(timePunchOut: DateTime.now, status: p.status+" / Finished @ #{Time.now.strftime('%-l:%M%P')}")
                flash[:out] = "Punched Out."
                redirect_to action: "index"
                return
              end
              if p.status == 'Started'
                p.update(timePunchOut: DateTime.now, status: "Punched out early @ #{Time.now.strftime('%-l:%M%P')}")
                flash[:error] = "You punched out early @ #{Time.now.strftime('%H:%M')}"
                redirect_to action: "index"
                return
              else
                p.update(timePunchOut: DateTime.now, status: p.status+" / Punched out early @ #{Time.now.strftime('%-l:%M%P')}")
                flash[:error] = "You punched out early @ #{Time.now.strftime('%H:%M')}"
                redirect_to action: "index"
                return
              end
            end
          end
        end
      end

      formatted = shift.start_time.to_date.strftime('%Y-%m-%d')
      if formatted === Date.today.strftime("%Y-%m-%d")
        if Time.now.strftime("%H-%M") <= shift.start_time.to_time.strftime("%H-%M")
          @punchy.timePunchIn = DateTime.now
          @punchy.timePunchOut = shift.end_time
          @punchy.status = "Punched in early @ #{Time.now.strftime('%H-%M')}"
        else
          @punchy.timePunchIn = DateTime.now
          @punchy.timePunchOut = shift.end_time
          @punchy.status = "Started"
        end
      else
        puts "#{Date.today.strftime("%Y-%m-%d")}"
        puts "#{formatted}"
      end
    end


    # If a timePunchIn doesnt exist that means the above condition wasnt met, which also means there was no
    # schedule for the user for the day
    if @punchy.timePunchIn === nil
      redirect_to action: "index"
      return
    end

    respond_to do |format|
      if @punchy.save
        flash[:out] = "Punched In."
        format.html { redirect_to action: "index" }
        format.json { render :show, status: :created, location: @punchy }
      else
        flash[:alert] = "You have already punched in for this shift"
        format.html { redirect_to @punchy.errors, status: unprocessable_entity }
        format.json { render json: @punchy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /punchies/1
  # PATCH/PUT /punchies/1.json
  def update
    respond_to do |format|
      if punchIn.update(punchy_params)
        format.html { redirect_to @punchy, notice: 'Punchy was successfully updated.' }
        format.json { render :show, status: :ok, location: @punchy }
      else
        format.html { render :edit }
        format.json { render json: @punchy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /punchies/1
  # DELETE /punchies/1.json
  def destroy
    @punchy.destroy
    respond_to do |format|
      format.html { redirect_to punchies_url, notice: 'Punchy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_punchy
      @punchy = Punchy.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def punchy_params
      params.permit(:user_id)
    end

    def check_if_email
      if punchy_params['user_id'] == ''
        redirect_to action: "index"
        return
      end
    end
end
