require 'rails_helper'

RSpec.describe User, type: :model do

  describe '正常系の機能' do
    context '新規登録する' do
      it '正しく登録できること ユーザー名: kou メールアドレス:test2@test.com,
        パスワード:password' do

        user = User.new(
          name: 'kou',
          email: 'test2@test.com',
          password: 'password',
          password_confirmation: 'password'
        )
        expect(user).to  be_valid
        user.save

        registered_user = User.find(1);

        expect(registered_user.name).to eq('kou')
        expect(registered_user.email).to eq('test2@test.com')
      end
    end
  end

  describe '入力項目の有無' do
    context '必須入力であること' do
      it 'お名前が必須であること' do
        new_user = User.new
        expect(new_user).not_to be_valid
        expect(new_user.errors.messages[:name]).to include(I18n.t("activerecord.errors.models.user.attributes.name.blank"))
      end
      it 'メールアドレスが必須入力であること' do
        new_user = User.new
        expect(new_user).not_to be_valid
        expect(new_user.errors[:email]).to include(I18n.t('activerecord.errors.models.user.attributes.email.blank'))
      end

      it '登録できないこと' do
        new_user = User.new
        expect(new_user.save).to be_falsey
      end
    end
  end
end
