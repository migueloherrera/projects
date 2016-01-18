require_relative '../caesar_cipher'

describe "Caesar Cipher" do
  it "requires two arguments" do
    expect(method(:caesar_cipher).arity).to eql(2)
  end
  it "is case sensitive" do
    expect(caesar_cipher("ABCabc", 1)).to eq("BCDbcd")
  end
  it "is not changing punctuation marks" do
    expect(caesar_cipher("!#@%$", 5)).to eq("!#@%$")
  end
  it "returns 'Bmfy f xywnsl!'" do
    expect(caesar_cipher("What a string!", 5)).to eq("Bmfy f xywnsl!")
  end
  it "wraps letters from the alphabet" do
    expect(caesar_cipher("XYZABC xyzabc", 31)).to eq("CDEFGH cdefgh")
  end
end
