# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  body       :text
#  user_id    :bigint           not null
#  task_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Note < ApplicationRecord
  # relaciones con otros modelos.
  belongs_to :user
  belongs_to :task

  # para validar que el input/campo no este vacio.
  validates :body, presence: :true
end
