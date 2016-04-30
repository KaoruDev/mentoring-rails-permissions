class Post < ActiveRecord::Base
  belongs_to :user

  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :user

  def collaborator_ids
    collaborations.pluck(:user_id)
  end
end
