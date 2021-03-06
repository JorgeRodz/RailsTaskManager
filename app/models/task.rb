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
#  owner_id    :bigint           not null
#  code        :string
#
class Task < ApplicationRecord

  # ----- ralciones y validacioens -----

  # Para decirle a rais que este modelo(task) pertenece a solo una categoria.
  belongs_to :category

  # ralacion de owner, con el modelo usuarios.
  belongs_to :owner, class_name: "User"

  # relacion con el modelo note
  has_many :notes

  # relacion con el model Participant donde decimos que una tarea puede tener muchos participantes
  has_many :participating_users, class_name: 'Participant'
  # relacion con el modelo User , donde decimos que una tarea puede tener muchos participantes, esto lo hacemos pasando como referencia la relacion que esta arriba.
  has_many :participants, through: :participating_users, source: :user
  # validacion para asegurarnos que el input no este vacio
  validates :participating_users, presence: :true
  # para agregar/eliminar formularios anidados en la vista.
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

  # ----- callbacks -----

  # para que antes de crear la tarea se agregue un codigo a ella.
  before_create :create_code
  def create_code
    self.code = "#{owner_id}#{Time.now.to_i.to_s(36)}#{SecureRandom.hex(8)}"
  end

  after_create :send_email
  def send_email
    (participants + [owner]).each do |user|
      ParticipantMailer.with(user: user, task: self).new_task_email.deliver!
    end
  end

end
