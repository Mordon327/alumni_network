class ProfilesController < ApplicationController

	def show
    end

    def index
    end
    
    def edit
    end

    def new
    end

    def create
    end

	def toggle_status
		byebug
		if @profiles.alumni
			@profiles.student
		elsif @profiles.student
			@profiles.alumni
		end
		redirect_to profile_url, notice: 'Profile status has been updated.'
	end

	def toggle_activity
		if @profiles.active
			@profiles.not_active
		elsif @profiles.not_active
			@profiles.active
		end
		redirect_to profile_url, notice: 'Profile status has been updated.'
	end

	def toggle_work
		if @profiles.full_time
			@profiles.contract

		elsif @profiles.contract
			@profiles.part_time

		elsif @profiles.part_time
			@profiles.full_time
		end
		redirect_to profile_url, notice: 'Profile status has been updated.'
	end

end
