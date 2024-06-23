class Category < ApplicationRecord

  # see https://github.com/amerine/acts_as_tree
  # belongs_to :parent, optional: true, class_name: "Category"
  # has_many :children, class_name: "Category", foreign_key: "parent_id"
  acts_as_tree order: "name"
  extend ActsAsTree::TreeView
  extend ActsAsTree::TreeWalker
end
