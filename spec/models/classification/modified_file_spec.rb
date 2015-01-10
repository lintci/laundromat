require 'spec_helper'

describe Classification::ModifiedFile do
  subject(:modified_file){build(:classification_modified_file)}

  its(:name){is_expected.to eq('bad.rb')}
  its(:lines){is_expected.to eq([1, 2, 3])}
end
