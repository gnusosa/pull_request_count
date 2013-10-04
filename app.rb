%w(sinatra octokit yaml haml).map {|gem| require gem}

get '/' do
  info = YAML.load_file('info.yml')
  auth_token = info['token']
  repo = info['repo']
  @client = Octokit::Client.new :access_token => auth_token
  @closed = @client.pull_requests(repo, 'state = closed')
  @open = @client.pull_requests(repo, 'state = open')
  haml :index, :format => :html5
end
