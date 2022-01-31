# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Category < ApplicationRecord
  # Para decirle a rails que este modelo(category) puede tener muchas task(tareas)
  has_many :tasks
end
