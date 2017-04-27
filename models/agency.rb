class Agency < ApplicationRecord
  if ENV['OLD'].present?
    belongs_to :node, dependent: :destroy
  else
    belongs_to :node, dependent: :destroy, optional: true
  end

  after_create :link_node
  around_save :update_node

  def link_node
    # mynode = Node.create class_name: self.class.to_s, is_deleted: is_deleted, name: name
    # self.node_id = mynode.id
    # self.save!
    create_node( class_name: self.class.to_s, is_deleted: is_deleted, name: name )
  end

  def update_node
    can_continue = !new_record?
    yield
    return true unless can_continue

    puts node.present?
    puts name_changed?
    puts is_deleted_changed?
    ##########
    ## This line is critical!!!! At this point node is not present.
    ## It looks like ActiveRecord/ActiveModel (not sure which) changed the
    ## order in which after_create gets called in relation to around_save.
    #
    ## I also wonder if this was an intentional change.
    ##########
    if node.present? && (name_changed? || is_deleted_changed?)
      # node.name = name
      # node.is_deleted = is_deleted
      # Agency.suppress do
        node.save
      # end
    end
  end
end
