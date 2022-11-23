class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true, length:{ maximum:100}
  validates :production_year, numericality: { less_than_or_equal_to: 2021 }
  validates :running_time, numericality: { greater_than: 60 }
  validates :rating, inclusion: { in:["G","PG12","R15+","R18+"],
   message: "%{value} is not included."}
end
