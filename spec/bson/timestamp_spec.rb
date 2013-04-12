# encoding: utf-8
require "spec_helper"

describe BSON::Timestamp do

  describe "#==" do

    let(:timestamp) do
      described_class.new(1, 10)
    end

    context "when the objects are equal" do

      let(:other) { described_class.new(1, 10) }

      it "returns true" do
        expect(timestamp).to eq(other)
      end
    end

    context "when the objects are not equal" do

      let(:other) { described_class.new(1, 15) }

      it "returns false" do
        expect(timestamp).to_not eq(other)
      end
    end

    context "when the other object is not a timestamp" do

      it "returns false" do
        expect(timestamp).to_not eq("test")
      end
    end
  end

  describe "#as_json" do

    let(:object) do
      described_class.new(10, 50)
    end

    it "returns the binary data plus type" do
      expect(object.as_json).to eq({ "t" => 10, "i" => 50 })
    end

    it_behaves_like "a JSON serializable object"
  end

  describe "#to_bson/#from_bson" do

    let(:type) { 17.chr }
    let(:obj)  { described_class.new(1, 10) }
    let(:bson) { [ 10, 1 ].pack("l2") }

    it_behaves_like "a bson element"
    it_behaves_like "a serializable bson element"
    it_behaves_like "a deserializable bson element"
  end
end