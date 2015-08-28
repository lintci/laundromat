module Github
  class Team
    NAME = 'LintCI'

    delegate :id, :name, :permission, :privacy, to: :team

    def initialize(team)
      @team = team
    end

    def lintci?
      name.downcase == NAME.downcase
    end

    def admin?
      permission == 'admin'
    end

  protected

    attr_reader :team
  end
end
