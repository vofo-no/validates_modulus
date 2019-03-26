require "active_model"

RSpec.describe ValidatesModulus do
  it "has a version number" do
    expect(ValidatesModulus::VERSION).not_to be nil
  end

  class MrBean
    include ActiveModel::Validations

    attr_accessor :number
    validates :number, modulus: :mod11
  end

  class Teddy < MrBean
    validates :number, modulus: { with: :mod11, message: "Oh no!!" }
  end

  it "mounts modulus validator" do
    expect(MrBean.validators_on(:number).first.class).to be ModulusValidator
  end

  describe "modulus 11 validation" do
    {
      "12345678903" => true,
      "12345678900" => false,
      "00000000000" => true,
      "11111111111" => false,
      "123" => false,
      "0365327" => true,
      12345678903 => true
    }.each do |value, expected_validity|
      it "validates modulus 11" do
        mr_bean = MrBean.new
        mr_bean.number = value
        expect(mr_bean.valid?).to be expected_validity
      end
    end
  end

  it "returns default error message" do
    mr_bean = MrBean.new
    mr_bean.number = 123
    mr_bean.valid?
    expect(mr_bean.errors.messages[:number]).to include "translation missing: en.activemodel.errors.models.mr_bean.attributes.number.bad_checksum"
  end

  it "returns custom error message" do
    teddy = Teddy.new
    teddy.number = 123
    teddy.valid?
    expect(teddy.errors.messages[:number]).to include "Oh no!!"
  end
end
