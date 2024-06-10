class Member < ApplicationRecord
  class << self
    def search(query)
      rel = order("number")
      if query.present?
        rel = rel.where("name LIKE ? OR full_name LIKE ?", "%#{query}%", "%#{query}%")
      end
      return rel
    end
  end
end
