require 'spec_helper'

describe Ashbe::Row do
  before do
    @data = { 'foo' => { 'one'    => '1', 'two' => '2' },
              'bar' => { 'four'   => '4', 'six' => '6' },
              'baz' => { 'wibble' => 'a' } }
    @row = ::Ashbe::Row.new( "12345", @data )
  end

  it "Has a key" do
    row = Ashbe::Row.new( 12345 )
    row.key.must_equal 12345
  end

  it "can be created from a nested hash" do

    @row.key.must_equal "12345"

    @row['foo']['one'].last_value.must_equal '1'
    @row.column_families.sort.must_equal @data.keys.sort
    @row.foo.one.last_value.must_equal '1'
  end

  it "can convert to a java Put object" do
    p = @row.to_put
    p.size.must_equal 5
    p.has( "foo".to_bytes, "one".to_bytes  ).must_equal true
  end

end
