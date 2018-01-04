# frozen_string_literal: true

RSpec.describe RbNaCl::Libsodium do
  it "has a version number" do
    expect(RbNaCl::Libsodium::VERSION).to be_a(String)
  end
end
