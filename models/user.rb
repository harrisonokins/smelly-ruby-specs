require 'sqlite3'

class User
  attr_accessor :id,
                :name,
                :most_popular,
                :views

  def self.find(id)
    row = DB.connection.get_first_row('SELECT * FROM users WHERE id = ?', id)

    return if row.empty?

    # Bind the attributes to a new user object
    new_user = User.new
    new_user.id = row[0]
    new_user.name = row[1]

    # Track this user's popularity
    new_user.increment_views

    # Return the user
    new_user
  end

  # NOTE: This purposely-bad method both violates
  # the Single-Responsibility Principle and
  # issues several DB reads and writes
  def increment_views
    # Increment the record in the DB
    DB.connection.execute('UPDATE users SET views = views + 1 WHERE id = ?', self.id)

    # Bind the new view count to the user
    self.views = DB.connection.get_first_value('SELECT views FROM users WHERE id = ?', self.id)

    # Check if this user is now the most popular user
    most_views = DB.connection.get_first_value('SELECT MAX(views) FROM users')
    self.most_popular = self.views == most_views

    # Update the most-popular DB users
    DB.connection.execute('UPDATE users SET most_popular = (users.views == ?)', most_views)

    return true
  end
end
