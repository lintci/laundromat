class Payload
  class PullRequest
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
      data['head']['repo']['git_url']
    end

    def owner
      data['head']['repo']['owner']['login']
    end

    def repo
      data['head']['repo']['name']
    end

    def ==(other)
      data == other.data
    end

    def inspect
      "<PullRequest:#{owner}/#{repo} (#{base_sha[0..6]}...#{head_sha[0..6]})>"
    end

    def comment(file, line, violations)
      Comment.new(self).add(file, line, violations)
    end

    def read_attribute_for_serialization(name)
      public_send(name)
    end

  protected

    attr_reader :data
  end
end
