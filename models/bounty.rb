require('pg')

class Bounty

  attr_accessor :name, :species, :bounty_value, :favourite_weapon

  attr_reader :id

  def initialize(options)
    @name = options['name']
    @species = options['species']
    @bounty_value = options['bounty_value'].to_i
    @favourite_weapon = options['favourite_weapon']
    @id = options['id'].to_i if options['id']
  end

  def save()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "INSERT INTO bounties
    (name, species, bounty_value, favourite_weapon)
    VALUES ($1, $2, $3, $4) RETURNING *"
    values = [@name, @species, @bounty_value, @favourite_weapon]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]['id'].to_i
    db.close
  end

  def update
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "UPDATE bounties
    SET (name, species, bounty_value, favourite_weapon)
    = ($1, $2, $3, $4) WHERE id = $5"
    values = [@name, @species, @bounty_value, @favourite_weapon, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  def Bounty.delete_all
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "DELETE FROM bounties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close
  end

  def delete
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "DELETE FROM bounties WHERE id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close
  end

  def Bounty.find_by_name(name)
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "SELECT * FROM bounties WHERE name = $1"
    values = [name]
    db.prepare("find_by_name", sql)
    arr = db.exec_prepared("find_by_name", values)
    if arr.count > 0
      first_hash = arr[0]
    else
      return nil
    end
    db.close
    return Bounty.new(first_hash)
  end

  def Bounty.find_by_id(id)
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "SELECT * FROM bounties WHERE id = $1"
    values = [id]
    db.prepare("find_by_id", sql)
    arr = db.exec_prepared("find_by_id", values)
    if arr.count > 0
      first_hash = arr[0]
    else
      return nil
    end
    db.close
    return Bounty.new(first_hash)
  end





end
