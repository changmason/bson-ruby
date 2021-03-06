# encoding: utf-8
require "spec_helper"

describe BSON::MinKey do

  describe "#as_json" do

    let(:object) do
      described_class.new
    end

    it "returns the binary data plus type" do
      expect(object.as_json).to eq({ "$minKey" => 1 })
    end

    it_behaves_like "a JSON serializable object"
  end

  describe "#==" do

    context "when the objects are equal" do

      let(:other) { described_class.new }

      it "returns true" do
        expect(subject).to eq(other)
      end
    end

    context "when the other object is not a max_key" do

      it "returns false" do
        expect(subject).to_not eq("test")
      end
    end
  end

  describe "#>" do

    it "always returns false" do
      expect(subject > Integer::MAX_64BIT).to be_false
    end
  end

  describe "#<" do

    it "always returns true" do
      expect(subject < Integer::MAX_64BIT).to be_true
    end
  end

  describe "#to_bson/#from_bson" do

    let(:type) { 255.chr }
    let(:obj)  { described_class.new }
    let(:bson) { BSON::NO_VALUE }

    it_behaves_like "a bson element"
    it_behaves_like "a serializable bson element"
    it_behaves_like "a deserializable bson element"
  end
end
