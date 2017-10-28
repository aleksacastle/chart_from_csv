class Session < ApplicationRecord

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Session.create! row.to_hash
    end
  end
end
