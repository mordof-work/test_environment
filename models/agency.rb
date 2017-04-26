class Agency < ApplicationRecord
  # Inverse of for the situation where node.rb has the has_one :agency
  # available
  if ENV['OLD'].present?
    belongs_to :node, dependent: :destroy
  else
    belongs_to :node, dependent: :destroy, optional: true
  end

  after_create :link_node
  around_save :update_node

  def link_node
    mynode = Node.create class_name: self.class.to_s, is_deleted: is_deleted, name: name
    self.node_id = mynode.id
    self.save!
    # create_node( class_name: self.class.to_s, is_deleted: is_deleted, name: name )
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
