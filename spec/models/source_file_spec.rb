require 'rails_helper'

describe SourceFile, type: :model do
  describe '#valid?' do
    subject(:source_file){build(:source_file)}

    %i(
      name language linters source_type size extension build
      binary generated vendored documentation image
    ).each do |attribute|
      it "requires #{attribute} to be set" do
        source_file.send(:"#{attribute}=", nil)

        expect(source_file).to_not be_valid
      end
    end
  end
end
