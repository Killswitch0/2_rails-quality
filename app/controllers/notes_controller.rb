class NotesController < ApplicationController
  def index
    @notes = Note.all.order(created_at: :desc)
  end

  def show
    # гем byebug запускает binding(связывание) irb непосредственно в тот момент,
    # когда мы хотим его вызвать
    # debugger
    @note = Note.find(params[:id])
  end
end
