class Movie < ActiveRecord::Base
  def self.all_ratings
    return ['G','PG','PG-13','R']
  end
  @checked_ratings = self.all_ratings
  def self.checked_ratings
    @checked_ratings
  end
  
  def self.checked_ratings=(new_checked)
    @checked_ratings = new_checked
  end
end
