require 'rails_helper'

describe 'Usuário entra na home' do
    it 'e vê receitas das pessoas que ele segue' do
        user_mateus = create(:user, email: 'mateus@email.com', password: '123456', role: :user)
        type_desert = create(:recipe_type, name: 'Sobremesa')
        create(:recipe_type, name: 'Lanche')
        create(:recipe, title: 'Manjar', cook_time: 60,
                    recipe_type: type_desert,
                    ingredients: 'leite condensado, leite, leite de coco',
                    instructions: 'Misture tudo, leve ao fogo e mexa, leve a geladeira', user: user_mateus)
        user_joao = create(:user, email: 'joao@email.com', password: '123456', role: :user)
        create(:recipe, title: 'Pudim', cook_time: 60,
                    recipe_type: type_desert,
                    ingredients: 'leite condensado, leite, leite de coco',
                    instructions: 'Misture tudo, leve ao fogo e mexa, leve a geladeira', user: user_joao)
        user_andre = create(:user, email: 'andre@email.com') 
        Follow.create!(follower: user_andre, followed_user: user_mateus)
        
        login_as(user_andre, scope: :user)
        visit root_path

        within('#seguidos') do
            expect(page).to have_content('Receitas dos Cheffs seguidos:')
            expect(page).to have_content('Manjar')
            expect(page).not_to have_content('Pudim')
        end
    end

    it 'e vê ranking de usuário por número de seeguidores' do
      user_mateus = create(:user, email: 'mateus@email.com')
      user_andre = create(:user, email: 'andre@email.com')
      user_joao = create(:user, email: 'joao@email.com')
      user_erika = create(:user, email: 'erika@email.com')
      Follow.create!(follower: user_andre, followed_user: user_joao)
      Follow.create!(follower: user_mateus, followed_user: user_joao)
      Follow.create!(follower: user_erika, followed_user: user_joao)

      Follow.create!(follower: user_andre, followed_user: user_erika)
      Follow.create!(follower: user_joao, followed_user: user_erika)

      Follow.create!(follower: user_mateus, followed_user: user_andre)

      Follow.create!(follower: user_andre, followed_user: user_mateus)

      visit root_path

      within '#ranking' do
        expect(page).to have_content 'Ranking Cheffs Populares'
        expect(page).to have_content '1. joao@email.com'
        expect(page).to have_content '2. erika@email.com'
        expect(page).to have_content '3. andre@email.com'
      end
    end
end