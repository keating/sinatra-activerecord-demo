
module HerokuDbUrl

  #"postgres://map:map@localhost/sinatrademo"
  def config_by_url(url)
    return nil if url.nil?
    user_arr = url[url.index('//')+2..-1].split(':') #["map", "map@localhost/sinatrademo"]
    user = user_arr[0]
    password_arr = user_arr[1].split('@')
    password = password_arr[0]
    host_arr = password_arr[1].split('/')
    host = host_arr[0]
    database = host_arr[1]
    {adapter: 'postgresql', host: host, database: database,
        username: user, password: password, encoding: 'utf8'}
  end

end