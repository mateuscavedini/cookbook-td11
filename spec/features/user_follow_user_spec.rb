require 'rails_helper'

describe 'User acessa receita de outro usuário' do
    it 'e vê botão de seguir usuário' do
        user_mateus = create(:user, email: 'mateus@email.com', password: '123456', role: :user)
        type_desert = create(:recipe_type, name: 'Sobremesa')
        create(:recipe_type, name: 'Lanche')
        create(:recipe, title: 'Manjar', cook_time: 60,
                    recipe_type: type_desert,
                    ingredients: 'leite condensado, leite, leite de coco',
                    instructions: 'Misture tudo, leve ao fogo e mexa, leve a geladeira', user: user_mateus)
        user_andre = create(:user, email: 'andre@email.com')
        
        login_as(user_andre, scope: :user)
        visit(root_path)
        click_on 'Manjar'

        expect(page).to have_content 'Manjar'
        expect(page).to have_content 'leite condensado, leite, leite de coco'
        expect(page).to have_button 'Seguir Cheff'

    end

    it 'e segue o autor da receita' do
      user_mateus = create(:user, email: 'mateus@email.com', password: '123456', role: :user)
      type_desert = create(:recipe_type, name: 'Sobremesa')
      create(:recipe_type, name: 'Lanche')
      manjar = create(:recipe, title: 'Manjar', cook_time: 60,
              recipe_type: type_desert,
              ingredients: 'leite condensado, leite, leite de coco',
              instructions: 'Misture tudo, leve ao fogo e mexa, leve a geladeira', user: user_mateus)
      user_andre = create(:user, email: 'andre@email.com')

      login_as user_andre, scope: :user
      visit recipe_path(manjar)
      click_on 'Seguir Cheff'

      expect(current_path).to eq recipe_path(manjar)
      expect(page).to have_button 'Deixar de Seguir'
      expect(page).not_to have_button 'Seguir Cheff'
      expect(page).to have_content 'Cheff seguido com sucesso!'
    end
end