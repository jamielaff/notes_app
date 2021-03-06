class NotesController < ApplicationController
  # Between these two methods,all actions are blacklisted unless specifically whitelisted
  skip_before_action :authorised,             only: [:index, :show]
  before_action :authorised_for_note_actions, except: [:index, :show, :new, :create, :pending, :approve]
  
  before_action :authorised_to_view_pending_note, only: [:show]
  before_action :authorised_for_moderation,       only: [:pending, :approve]

  def index
    @notes = Note.by_admin.active.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
  end

  def show
    @note = Note.find(params[:id])
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    @note.user = current_user
    if @note.save
      respond_to do |format|
        format.js {
          flash[:alert] = "Your note was successfully created, and is pending moderation"
          render js: "window.location = '#{note_path(@note)}'"
        }
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
  end

  def update
    if @note.update(note_params)
      respond_to do |format|
        format.js {
          flash[:success] = "Note was updated"
          render js: "window.location = '#{note_path(@note)}'"
        }
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @note.destroy
    flash[:success] = "Note was deleted"
    redirect_to root_path
  end

  def pending
    @notes = Note.pending.paginate(page: params[:page], per_page: 5)
  end

  def approve
    @note = Note.find(params[:note_id])
    if @note.approve
      flash[:success] = "Note was approved"
    else
      flash[:danger] = "Something went wrong approving this note"
    end
    redirect_to pending_notes_path
  end

  private

  def note_params
    params.require(:note).permit(:title, :description)
  end

  def authorised_to_view_pending_note
    @note = Note.find(params[:id])
    # This is worthy of a refactor
    unless @note.active? || logged_in_as_admin? || (logged_in? && @note.owned_by?(current_user))
      flash[:danger] = "You are not authorised to perform that action"
      redirect_to root_path
    end
  end

  # Applies to edit, update & destroy
  def authorised_for_note_actions
    @note = Note.find(params[:id])
    unless @note.owned_by?(current_user) || logged_in_as_admin?
      flash[:danger] = "You are not authorised to perform that action"
      redirect_to root_path
    end
  end

  def authorised_for_moderation
    unless logged_in_as_admin?
      flash[:danger] = "You are not authorised to perform that action"
      redirect_to root_path
    end
  end
end
