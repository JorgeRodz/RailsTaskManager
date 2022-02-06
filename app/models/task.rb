# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  due_date    :date
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
  # Para decirle a rais que este modelo(task) pertenece a solo una categoria.
  belongs_to :category

  # ralacion de owner, con el modelo usuarios.
  belongs_to :owner, class_name: "User"

  # relacion con el model Participant donde decimos que una tarea puede tener muchos participantes
  has_many :participating_users, class_name: 'Participant'
  # relacion con el modelo User , donde decimos que una tarea puede tener muchos participantes, esto lo hacemos pasando como referencia la relacion que esta arriba.
  has_many :participants, through: :participating_users, source: :user
  # validacion para asegurarnos que el input no este vacio
  validates :participating_users, presence: :true
  # para agregar/eliminar participantes(user) a la tarea
  accepts_nested_attributes_for :participating_users, allow_destroy: true

   # validacion para que los inputs no esten vacios
   validates :name, :description, presence: true

   # validacion para que cada registro sea unico tamnando en cuenta mayusculas y minusculas
   validates :name, uniqueness: { case_sensitive: false }

   # validacion personalizada para la fecha
   validate :due_date_validity

   def due_date_validity
     return if due_date.blank?
     return if due_date > Date.today
     errors.add :due_date, I18n.t('task.errors.invalid_due_date')
   end

end
