class Agency < ApplicationRecord
  if ENV['TEST'].present?
    # Inverse of for the situation where node.rb has the has_one :agency
    # available
    belongs_to :node, dependent: :destroy, inverse_of: :agency, optional: true
  else
    belongs_to :node, dependent: :destroy, optional: true
  end

  after_create :link_node
  around_save :update_node

  def link_node
    create_node( class_name: self.class.to_s, is_deleted: is_deleted, name: name )
  end

  def update_node
    can_continue = !new_record?
    yield
    return true unless can_continue
    if node.present? && (name_changed? || is_deleted_changed?)
      node.name = name
      node.is_deleted = is_deleted
      node.save
    end
  end
end
