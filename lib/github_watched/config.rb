require 'shellwords'

module GitHubWatched::Config
  extend self

  def git_config(name)
    value = `git config --get #{Shellwords.escape name}`.chomp
    value if $?.success?
  end

  def github_username
    git_config('github.user') or raise 'GitHub username not set. Use `git config --global github.user username` to set.'
  end
end
