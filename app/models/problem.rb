class Problem < ApplicationRecord
  enum difficulty: {
    Easy: 1,
    Medium: 2,
    Hard: 3
  }, _prefix: true
end
