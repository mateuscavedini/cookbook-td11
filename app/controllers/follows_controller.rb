class FollowsController < ApplicationController

    def create
        followed = User.find(params[:followed_id])
        recipe = Recipe.find(params[:recipe_id])
        relationship = Follow.new(follower: current_user, followed_user: followed)
        if relationship.save
            redirect_to recipe_path(recipe), notice: 'Cheff seguido com sucesso!'
        else
            redirect_to recipe_path(recipe), alert: 'Não foi possível seguir esse Cheff!'
        end
    end
end