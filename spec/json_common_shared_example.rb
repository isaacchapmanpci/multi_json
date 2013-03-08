shared_examples_for 'JSON-like adapter' do |adapter|
  before{ MultiJson.use adapter }

  describe '.dump' do
    before{ MultiJson.dump_options = MultiJson.adapter.dump_options = nil }

    describe 'with :pretty option set to true' do
      it 'passes default pretty options' do
        object = 'foo'
        object.should_receive(:to_json).with(JSON::PRETTY_STATE_PROTOTYPE.to_h).and_return('["foo"]')
        MultiJson.dump(object, :pretty => true)
      end
    end

    describe 'with :indent option' do
      it 'passes it on dump' do
        object = 'foo'
        object.should_receive(:to_json).with(:indent => "\t").and_return('["foo"]')
        MultiJson.dump(object, :indent => "\t")
      end
    end
  end

  describe '.load' do
    it 'passes :quirks_mode option' do
      ::JSON.should_receive(:parse).with('["foo"]', {:quirks_mode => true, :create_additions => false}).and_return(['foo'])
      MultiJson.load('"foo"', :quirks_mode => true)
    end
  end
end