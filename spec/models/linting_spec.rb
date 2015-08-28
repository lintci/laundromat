require 'spec_helper'

describe Linting do
  subject(:linting){build(:linting)}
  it{is_expected.to have_attributes(task_id: 1)}
  it{is_expected.to_not be_clean}
end
