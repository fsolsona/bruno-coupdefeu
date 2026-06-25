class KnowledgeItem < ApplicationRecord
  validates :category, presence: true
  validates :content, presence: true
end
