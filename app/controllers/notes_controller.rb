class NotesController < ApplicationController
  skip_before_action :authorised, only: [:index, :show]

  before_action :set_note, only: [:show, :update, :destroy]
  before_action :authorised_for_note_actions, except: [:index, :new, :create, :show]

  def index
    @notes = Note.paginate(page: params[:page], per_page: 5)
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    @note.user = current_user
    if @note.save
      flash[:success] = "Note was successfully created"
      redirect_to note_path(@note)
    else
      render 'new'
    end
  end

  def show
  end

  def update
    if @note.update(note_params)
      flash[:success] = "Note was updated"
      redirect_to note_path(@note)
     else
      flash[:success] = "Note was not updated"
      render 'edit'
     end
  end

  def destroy
    @note.destroy
    flash[:success] = "Note was deleted"
    redirect_to root_path
  end

  private

  def note_params
    params.require(:note).permit(:title, :description)
  end

  def set_note
    @note = Note.find(params[:id])
  end

  def authorised_for_note_actions
    unless @note.owned_by?(current_user) || logged_in_as_admin?
      flash[:danger] = "You are not authorised to perform that action"
      redirect_to root_path
    end
  end
end
