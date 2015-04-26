require 'spec_helper'

describe Analysis do
  subject(:analysis){build(:analysis)}

  its(:task_id){is_expected.to eq(1)}
  its(:source_files){is_expected.to match([be_a(SourceFile), be_a(SourceFile), be_a(SourceFile)])}
end
