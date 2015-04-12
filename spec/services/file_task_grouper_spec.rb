require 'spec_helper'

describe FileTaskGrouper do
  let(:source_files) do
    [
      build(:ruby_source_file),
      build(:text_source_file),
      build(:ruby_source_file)
    ]
  end
  subject(:grouper){FileTaskGrouper.new(source_files)}

  describe '#groups' do
    def find_group(grouper, language)
      grouper.groups.find{|group| group.language == language}
    end

    it 'does not create a group for files with unknown linters' do
      expect(find_group(grouper, 'Text')).to be_falsey
    end

    it 'groups files with the same linter together' do
      group = find_group(grouper, 'Ruby')
      expect(group.source_files.size).to eq(2)
    end
  end
end
