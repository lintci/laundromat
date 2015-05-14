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

  describe '#add_violations' do
    subject(:source_file){create(:source_file)}
    let(:violations){[build(:violation)]}
    let(:additional_violations){[build(:violation)]}

    context 'when adding new violations' do
      it 'adds the violations' do
        source_file.add_violations(violations)

        expect(source_file.violations).to eq(violations)
      end
    end

    context 'when adding additional violations' do
      it 'adds the additional violations' do
        source_file.add_violations(violations)
        source_file.add_violations(additional_violations)

        expect(source_file.violations).to eq(violations + additional_violations)
      end
    end
  end
end
