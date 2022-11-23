require 'rails_helper'

RSpec.describe Movie, type: :model do
  # タイトルと製作年と上映時間と映倫区分があれば有効な状態であること
  it "is valid with a title, production_year, running_time, rating" do
    movie = Movie.new(
      title: 'DIC',
      production_year: 2000,
      running_time: 120,
      rating: 'G')
    expect(movie).to be_valid
  end
  # タイトルがなければ無効な状態であること
  it "is invalid without a title" do
    movie = Movie.new(title: nil)
    movie.valid?
    expect(movie.errors[:title]).to include("can't be blank")
  end
  # 重複したタイトルなら無効な状態であること
  it "is invalid with a duplicate title" do
    Movie.create(
      title: 'DIC',
      production_year: 2000,
      running_time: 120,
      rating: 'G')
    movie = Movie.new(
      title: 'DIC',
      production_year: 3000,
      running_time: 150,
      rating: 'PG12')
    movie.valid?
    expect(movie.errors[:title]).to include("has already been taken")
  end
  # タイトルが101文字以上なら無効な状態であること
  it "is invalid with title is 101 or more characters" do
    movie = Movie.new(title: 'a' * 101)
    movie.valid?
    expect(movie.errors[:title]).to include("is too long (maximum is 100 characters)")
  end

  #制作年が2021年以上だと無効
  it "is invalid with production year is more than 2021" do
    movie = Movie.new(
      title:'DICTOKYO',
      production_year: 2022
    )
    expect(movie).not_to be_valid
  end

  #上映時間が60分以下だと無効
  it "is invalid with running time is less than 60" do
    movie = Movie.new(
      title: "MKmovie",
      running_time: 50
    )
    expect(movie).not_to be_valid
  end

  #映倫区分がG,PG12,R15+,R18+以外の文字が入ると無効
  it "is invalid without rating word" do
    movie = Movie.new(
      title: "goast",
      rating: "R14+"
    )
    expect(movie).not_to be_valid 
  end

  #映像区分が無効な場合、エラーメッセージの確認
  # it "is invalid and come up this error message without rating word " do
  #   movie = Movie.new(
  #     title: "MK",
  #     rating: "GG"
  #   )
  #   expect(movie.errors[:rating]).to include ("is not included")
  # end
end