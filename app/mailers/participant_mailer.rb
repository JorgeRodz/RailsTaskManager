class ParticipantMailer < ApplicationMailer

  def new_task_email
    @user = params[:user]
    @task = params[:task]
  end

  mail to:@user.email, subject: 'Tarea Asignada'

end
