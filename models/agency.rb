class Agency < ApplicationRecord
  if ENV['OLD'].present?
    belongs_to :node, dependent: :destroy
  else
    belongs_to :node, dependent: :destroy, optional: true
  end

  after_create :link_node
  around_save :update_node

  def link_node
    puts "Created Node"
    puts "new after node create?: #{new_record?}"
    puts "name changed after node create?: #{name_changed?}"
    @freshly_made_node = true
    create_node class_name: self.class.to_s, name: self.name, is_deleted: self.is_deleted
  end

  def update_node
    @count ||= 0
    rnd = Random.rand(1000)
    puts '-' * ENV['WIDTH'].to_i
    puts "New Record: #{new_record?}"
    puts "Fresh Node: #{@freshly_made_node}"
    puts "Node Present?: #{node.present?}" if ENV['REFER_BEFORE']
    puts "Node Present?: --------" unless ENV['REFER_BEFORE']
    puts "Name Changed?: #{name_changed?}"
    puts '-' * ENV['WIDTH'].to_i
    puts "Before Save #{rnd}"
    yield
    puts "After Save #{rnd}"
    @count += 1
    if @count > 3
      puts "~~ Hit the Count Limit ~~"
      return
    end
    # puts "Node2 Present?: #{node.present?}"
    if node.present? && (name_changed? || is_deleted_changed?)
      @freshly_made_node = false
      node.name = name
      node.is_deleted = is_deleted
      node.save
    end
  end
end
