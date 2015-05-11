require 'spec_helper'

describe Query do
  subject(:query){described_class.new}

  describe '#to_sql' do
    context 'with no implementation of scope' do
      it 'raises an exception' do
        expect{query.to_sql}.to raise_error(NotImplementedError, 'Subclass must define scope.')
      end
    end
  end
end
