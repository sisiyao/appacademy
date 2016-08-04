class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @note.track_id = params[:track_id]
    @note.save!
    redirect_to track_url(@note.track)
  end

  def destroy
    @note = Note.find(params[:id])

    if current_user.id != @note.user_id
      render text: "You can only destroy your own notes.", status: 403
    else
      @note.destroy
      redirect_to track_url(@note.track)
    end
  end

  private
  def note_params
    params.require(:note).permit(:user_id, :track_id, :content)
  end
end
