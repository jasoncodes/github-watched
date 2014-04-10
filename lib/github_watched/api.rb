require 'octocat_herder'

module GitHubWatched::API
  class Base
    def connection
      OctocatHerder::Connection.headers['User-Agent'] = "github-watched/#{GitHubWatched::VERSION} (+https://github.com/jasoncodes/github-watched)"
      @connection ||= OctocatHerder::Connection.new
    end

    def list(end_point, options = {})
      paginated = options.delete(:paginated)
      klass = options.delete(:klass)
      options[:params] ||= {}
      options[:params][:per_page] ||= 100

      Enumerator.new do |y|
        begin
          result = connection.raw_get(end_point, options)
          raise "Unable to retrieve #{end_point}" unless result

          result.parsed_response.each do |item|
            item = klass.new(item, connection) if klass
            y << item
          end

          options[:params][:page] = paginated && connection.page_from_headers(result.headers, 'next')
        end while options[:params][:page]
      end
    end
  end

  class User < Base
    attr_accessor :username

    def initialize(username)
      @username = username
    end

    def watched
      list "/users/#{CGI.escape(username)}/watched", :paginated => true, :klass => OctocatHerder::Repository
    end
  end
end
