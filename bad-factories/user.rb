require 'sqlite3'

class BadFactories
  class User
    def self.build(type)
      user = send("build_#{type}_user")

      # Insert the attributes into the DB
      DB.connection.execute(
        'INSERT INTO users (id, name, views, most_popular) values (?, ?, ?, ?)',
        user.id,
        user.name,
        user.views,
        user.most_popular ? 1 : 0
      )

      user
    end

    def self.build_standard_user
      user = ::User.find(1)

      if user.nil?
        user = ::User.new
        user.id = 1
        user.name = 'Standard User'
        user.most_popular = false
      end

      user
    end

    def self.build_admin_user
      user = ::User.find(2)

      if user.nil?
        user = ::User.new
        user.id = 2
        user.name = 'Super User'
        user.most_popular = false
      end

      user
    end

    def self.build_popular_user
      user = ::User.find(3)

      if user.nil?
        user = ::User.new
        user.id = 3
        user.name = 'Popular User'
        user.views = 1_000
        user.most_popular = true
      end

      user
    end
  end
end
