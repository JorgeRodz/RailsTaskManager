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
