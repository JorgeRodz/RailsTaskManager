class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # relacion con las tareas como usuario owner; osea un usuario es owner de una tarea cuando este la crea
  has_many :owned_task, class_name: 'Task'

  # relacion de un usuario como participante
  has_many :participations, class_name: 'Participant'
  # relacion de las tareas de usuario como participante
  has_many :task, through: :participations
end
