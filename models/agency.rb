class Agency < ApplicationRecord
  if ENV['OLD'].present?
    belongs_to :node, dependent: :destroy
  else
    belongs_to :node, dependent: :destroy, optional: true
  end

  after_create :link_node
  after_update :update_node

  def link_node
    create_node class_name: self.class.to_s, name: self.name, is_deleted: self.is_deleted
  end

  def update_node
    # the @node_updated_details is the important part in resolving this endless circular reference.
    # it keeps track of the name, and is_deleted details being set on the node.
    #
    # If the node details is missing, or node details are not the details the
    # agency currently has, it'll go through. if it's present, and matching -
    # then we won't try to save the node *again*.

    if @node_updated_details.present?
      if @node_updated_details[:name] == name && @node_updated_details[:is_deleted] == is_deleted
        # this double-if block is a cleaner way to write it than a single line
        # if statement below. We don't want to continue if we're already attempting
        # to set the details here.
        return
      end
    end

    if node.present? && (name_changed? || is_deleted_changed?)
      @node_updated_details = { name: name, is_deleted: is_deleted }
      node.name = name
      node.is_deleted = is_deleted
      node.save
      @node_updated_details = false
    end
  end
end
