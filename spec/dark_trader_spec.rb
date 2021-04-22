require 'rubocop'
require 'pry'
require_relative '../lib/dark_trader'

describe "the array_hash method" do
  it "return an array" do
    expect(array_hash.class).to eq(Array)
  end
end 

describe "The array_crypto_name method" do
  it "Include BTC" do
    expect(array_crypto_name.include?("BTC")).to eq(true)
  end
  it "Include ETH" do
    expect(array_crypto_name.include?("ETH")).to eq(true)
  end
  it "Not include xabi" do
    expect(array_crypto_name.include?("pascaline")).to eq(false)
  end
end

describe "The array_crypto_value method" do
  it "size > 100" do
    expect(array_crypto_value.size>100).to eq(true)
  end
  it "size < 50" do
    expect(array_crypto_name.size<50).to eq(false)
  end
end

