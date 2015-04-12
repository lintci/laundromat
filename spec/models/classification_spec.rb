require 'spec_helper'

describe Classification do
  subject(:classification){build(:classification)}

  its(:task_id){is_expected.to eq(1)}
  its(:source_files){is_expected.to match([be_a(SourceFile), be_a(SourceFile), be_a(SourceFile)])}
end
