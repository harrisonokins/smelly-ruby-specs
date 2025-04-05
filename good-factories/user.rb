require 'sqlite3'

class GoodFactories
  class User
    def self.build(type)
      send("build_#{type}_user")
    end

    def self.create(type)
      user = self.build(type)

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
      user = ::User.new
      user.name = 'Standard User'
      user.most_popular = false
      user
    end

    def self.build_admin_user
      user = ::User.new
      user.name = 'Super User'
      user.most_popular = false
      user
    end

    def self.build_popular_user
      user = ::User.new
      user.name = 'Popular User'
      user.views = 1_000
      user.most_popular = true
      user
    end
  end
end
