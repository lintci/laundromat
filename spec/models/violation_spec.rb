require 'rails_helper'

describe Violation, type: :model do
  describe '#valid?' do
    subject(:violation){build(:violation)}

    %i(source_file message).each do |attribute|
      it "requires #{attribute}" do
        violation.send(:"#{attribute}=", nil)

        expect(violation).to_not be_valid
      end
    end
  end
end
