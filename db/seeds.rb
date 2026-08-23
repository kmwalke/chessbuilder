# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

PieceCardUtil.populate

[
  { email: 'kmwalke@gmail.com', name: 'Kent', motto: 'That\'s streets ahead!', role: User::ADMIN },
  { email: 'kfretz2@gmail.com', name: 'Keith', motto: 'But Prestidigitation _is_ a combat skill!', role: User::ADMIN },
  { email: 'cristin.slaymaker@gmail.com', name: 'Cris' },
  { email: 'kerryslaymaker@gmail.com', name: 'Kerry' },
  { email: 'buttforker@gmail.com', name: 'Zack' },
  { email: 'Aaron.m.lee.al@gmail.com', name: 'Aaron' },
  { email: 'polymangler@gmail.com', name: 'Bruce' },
  { email: 'a@b.com', name: 'Lumber Jack' },
  { email: 'b@b.com', name: 'Shifty Rogue' }
].each do |user_params|
  @user                       = User.find_or_create_by(user_params)
  @user.password              = '123'
  @user.save
end
