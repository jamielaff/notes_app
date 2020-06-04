class NotesController < ApplicationController
  def index
    @notes = Note.paginate(page: params[:page], per_page: 5)
  end

  def new
    @note = Note.new
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
    @note.destroy
    flash[:success] = "Note was deleted"
    redirect_to notes_path
  end
end
