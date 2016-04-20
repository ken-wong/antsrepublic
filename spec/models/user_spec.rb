require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid" do
    expect(create(:user)).to be_valid
  end

  it "is invalid without email" do
    user = build(:user, email: nil)
    user.valid?
    expect(user).to be_invalid
    expect(user.errors[:email].first).to eq I18n.t("errors.messages.blank")
  end

  it "is invalid with duplicate email" do
    create(:user)
    user = build(:user)
    user.valid?
    expect(user).to be_invalid
    expect(user.errors[:email].first).to eq I18n.t("errors.messages.taken")
  end

  it "is invalid without password" do
    user = build(:user, password: nil, password_confirmation: nil)
    user.valid?
    expect(user).to be_invalid
    expect(user.errors[:password].first).to eq I18n.t("errors.messages.blank")
  end

  it "is invalid if password and password_confirmation not match" do
    user = build(:user, password: "not_match")
    user.valid?
    expect(user).to be_invalid
    expect(user.errors[:password_confirmation].first).to eq I18n.t("errors.messages.confirmation")
  end
end
