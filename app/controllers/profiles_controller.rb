class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :destroy, :update, :edit, :toggle_status, :toggle_activity, :toggle_work]


	  def show
		  @profile = Profile.find(params[:id])
    end

    def index
    	@profile = Profile.all
    end
    
    def edit
    end

    def new
        @profile = Profile.new
    end

    def create
    @profile = Profile.new(profile_params)
    
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Your profile is now live.' }
      else
        format.html { render :new }
      end
    end
  end


    def update
        if current_user.id == @profile.users_id || current_user.role == :admin
            respond_to do |format|     
               if @profile.update(profile_params)
              format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
            else
              format.html { render :edit }
              end
            end
        else
            redirect_to root_path, notice: "You are not allowed to do that"
        end
    end  

    def destroy
        if current_user.id == @profile.users_id || current_user.role == :admin
            @profile.destroy
            respond_to do |format|
            format.html { redirect_to profiles_url, notice: 'Profile was removed.' }
            end
        else
            redirect_to root_path, notice: "You are not allowed to do that"
        end
    end  

    def create
    end

	def toggle_status
		
		if @profile.alumni?
			@profile.student!
		elsif @profile.student?
			@profile.alumni!
		end
		redirect_to profile_url, notice: 'Profile status has been updated.'
	end

	def toggle_activity
		if @profile.active?
			@profile.not_active!
		elsif @profile.not_active?
			@profile.active!
		end
		redirect_to profile_url, notice: 'Profile status has been updated.'
	end

	def toggle_work
		if @profile.full_time?
			@profile.contract!

		elsif @profile.contract?
			@profile.part_time!

		elsif @profile.part_time?
			@profile.full_time!
		end
		redirect_to profile_url, notice: 'Profile status has been updated.'
	end

  private 

  def profile_params
      params.require(:profile).permit(:name,
                                      :about,
                                      :phone,
                                      :email,
                                      :location,
                                      :relocation,
                                      :skills,
                                      :img
                                      )
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end
end
