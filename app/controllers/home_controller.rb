class HomeController < ApplicationController
  def index
    @recipes = Recipe.all
    @recipe_types = RecipeType.all
    @users = User.all.sort_by { |user| -user.followers.length }
  end
end
