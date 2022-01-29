# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do

  let!(:production) { create(:production, title:'hoge',introduction:'body') }
  let!(:customer) { create(:customer) }
  before { sign_in customer }

  describe '詳細画面(production_path)のテスト' do
    before do
      visit production_path
    end
  end

  describe "投稿画面(new_production_path)のテスト" do
    before do
      visit new_production_path
    end
    context '表示の確認' do
      it 'new_productionが"/productions/new"であるか' do
        expect(current_path).to eq('/productions/new')
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button 'create'
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'production[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'production[introduction]', with: Faker::Lorem.characters(number:20)
        click_button 'create'
        expect(page).to have_current_path production_path(Production.last)
      end
    end
  end

  describe "投稿一覧のテスト" do
    before do
      visit productions_path
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content production.title
        expect(page).to have_link production.title
      end
    end
  end

  describe "詳細画面のテスト" do
    before do
      visit production_path(production)
    end
    context '表示の確認' do
      it '削除リンクが存在しているか' do
        expect(page).to have_link '削除'
      end
      it '編集リンクが存在しているか' do
        expect(page).to have_link '編集'
      end
    end
    context 'リンクの遷移先の確認' do
      it '編集の遷移先は編集画面か' do
        edit_link = find_all('a')[3]
        edit_link.click
        expect(current_path).to eq('/productions/' + production.id.to_s + '/edit')
      end
    end
    context 'prodction削除のテスト' do
      it 'productionの削除' do
        expect{ production.destroy }.to change{ Production.count }.by(-1)
      end
    end
  end

  describe '編集画面のテスト' do
    before do
      visit edit_production_path(production)
    end
    context '表示の確認' do
      it '編集前のタイトルと作品説明がフォームに表示(セット)されている' do
        expect(page).to have_field 'production[title]', with: production.title
        expect(page).to have_field 'production[introduction]', with: production.body
      end
      it '保存ボタンが表示される' do
        expect(page).to have_button '編集内容を保存'
      end
    end
    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'production[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'production[introduction]', with: Faker::Lorem.characters(number:20)
        click_button '編集内容を保存'
        expect(page).to have_current_path production_path(production)
      end
    end
  end
end