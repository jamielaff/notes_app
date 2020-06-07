module NotesHelper
  def created_by_name(note)
    if note.user.present?
      note.user.username
    else
      '[Removed user]'
    end
  end
end
