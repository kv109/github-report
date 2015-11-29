Octokit.configure do |c|
  c.login = ENV['GITHUB_LOGIN']
  c.password = ENV['GITHUB_PASSWORD']
end
