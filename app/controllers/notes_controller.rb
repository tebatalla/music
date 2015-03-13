class NotesController < ApplicationController
  before_action :require_log_in
  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @note.save
    redirect_to track_url(@note.track)
  end

  def destroy
    @note = Note.find(params[:id])
    if @note.user == current_user
      @note.try(:destroy)
      redirect_to track_url(@note.track)
    else
      render status: :forbidden
    end
  end

  private
  def note_params
    params.require(:note).permit([:body, :track_id])
  end
end
