# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # para que el usuario owner puda gestionar tareas, y los participantes de una tarea puedan visualizarla.
    can :manage, Task, owner_id: user.id

    # para que los participantes de una tarea puedan visializarla.
    can :read, Task, participating_users: { user_id: user.id }
  end
end
