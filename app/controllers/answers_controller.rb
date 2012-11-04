class AnswersController < ApplicationController
  def create
    if current_user
      Answer.add_answer(params, current_user.uid)
    end
  end
  
  def delete
    answer = Answer.find_by_id(params[:id])
    if answer.user_id == current_user.uid
      answer.destroy
      render :nothing => true
    end
  end
  
  def vote
    vote = Vote.where(:user_id => current_user.uid, :answer_id => params[:answer_id]).all
    if vote.length == 0
      vote.add_vote(params, current_user.uid)
    end
  end
  
  def show
    if current_user
      @question = Question.find_by_id(params[:question_id])
      if @question      
        @answers = Answer.where(:question_id => @question.id).all
        render :layout => false
      else
        render :nothing => true
      end
    else
      render :nothing => true
    end
  end
  
end
