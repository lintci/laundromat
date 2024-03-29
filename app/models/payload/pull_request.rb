class Payload
  # Pull request information from a payload
  class PullRequest
    class << self
      def model_name
        ActiveModel::Name.new(self, Payload, 'PullRequest')
      end
    end

    def initialize(data)
      @data = data
    end

    def id
      data['number']
    end

    def base_sha
      data['base']['sha']
    end

    def head_sha
      data['head']['sha']
    end

    def branch
      data['head']['ref']
    end

    def clone_url
      "git://github.com/#{owner}/#{repo}.git"
    end

    def owner
      data['head']['repo']['owner']['login']
    end

    def repo
      data['head']['repo']['name']
    end

    def repo_full_name
      "#{owner}/#{repo}"
    end

    def ==(other)
      data == other.data
    end

    def inspect
      "<PullRequest:#{owner}/#{repo} (#{base_sha[0..6]}...#{head_sha[0..6]})>"
    end

    def read_attribute_for_serialization(name)
      public_send(name)
    end

  protected

    attr_reader :data
  end
end
