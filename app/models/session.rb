class Session < ApplicationRecord

  def self.import(file)
    CSV.foreeach(file.path, header: true) do |row|
      Session.create! row.to_hash
    end
  end
end
