# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# coding: utf-8

# 管理者アカウント
Admin.create!(
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD']
)

# ユーザーテストデータ
eiichi = User.find_or_create_by!(email: "eiichi@example.com") do |user|
  user.name = "渋沢栄一"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.JPG"), filename:"sample-user1.JPG")
end

takamori = User.find_or_create_by!(email: "takamori@example.com") do |user|
  user.name = "西郷隆盛"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.JPG"), filename:"sample-user2.JPG")
end

taisuke = User.find_or_create_by!(email: "taisuke@example.com") do |user|
  user.name = "板垣退助"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.JPG"), filename:"sample-user3.JPG")
end