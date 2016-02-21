class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @meetings = Meeting.all
  end

  def show
  end

  def new
    @meeting = current_user.meetings.build
  end

  def edit
  end

  def create
    @meeting = current_user.meetings.build(meeting_params)
      if @meeting.save
        redirect_to @meeting, notice: 'Meeting was successfully created.'
      else
        render :new 
      end
  end

  def update
    if @meeting.update(meeting_params)
      redirect_to @meeting, notice: 'Meeting was successfully updated.' 
    else
      render :edit 
    end 
  end

  def destroy
    @meeting.destroy
    redirect_to meetings_url, notice: 'Meeting was successfully destroyed.'
  end

  private
    def correct_user
      @meeting = current_user.meetings.find_by(id: params[:id])
      redirect_to meetings_path, notice: "Not authorized" if @meeting.nil?
    end

    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    def meeting_params
      params.require(:meeting).permit(:name)
    end
end
