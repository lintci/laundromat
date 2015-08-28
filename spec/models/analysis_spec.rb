require 'spec_helper'

describe Analysis do
  subject(:analysis){build(:analysis)}

  it do
    is_expected.to have_attributes(
      task_id: 1,
      source_files: match([be_a(SourceFile), be_a(SourceFile), be_a(SourceFile)])
    )
  end
end
