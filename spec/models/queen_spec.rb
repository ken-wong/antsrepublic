require 'rails_helper'

RSpec.describe Queen, type: :model do
  it "is valid" do
    expect(create(:queen)).to be_valid
  end

  it "is invalid without email" do
    queen = build(:queen, email: nil)
    queen.valid?
    expect(queen).to be_invalid
    expect(queen.errors[:email].first).to eq I18n.t("errors.messages.blank")
  end

  it "is invalid with duplicate email" do
    create(:queen)
    queen = build(:queen)
    queen.valid?
    expect(queen).to be_invalid
    expect(queen.errors[:email].first).to eq I18n.t("errors.messages.taken")
  end

  it "is invalid without password" do
    queen = build(:queen, password: nil, password_confirmation: nil)
    queen.valid?
    expect(queen).to be_invalid
    expect(queen.errors[:password].first).to eq I18n.t("errors.messages.blank")
  end

  it "is invalid if password and password_confirmation not match" do
    queen = build(:queen, password: "not_match")
    queen.valid?
    expect(queen).to be_invalid
    expect(queen.errors[:password_confirmation].first).to eq I18n.t("errors.messages.confirmation")
  end
end
