require 'net/http'
require 'json'
require 'tagfish/docker_uri'
require 'tagfish/api_call'
require 'tagfish/tags'

module Tagfish
  class DockerRegistryVbothClient

    attr_accessor :docker_uri
    attr_accessor :api_call

    def initialize(docker_uri, debug)
      @api_call = APICall.new(debug)
      @docker_uri = docker_uri
      code = api_call.get(ping_uri).code
      if code == 401
        api_call.auth(docker_uri.registry)
        code = api_call.get(ping_uri).code
      end
      if code == 401
        raise DockerRegistryClient::AuthenticationError, "Please `docker login <REGISTRY>` and try again"
      elsif code != 200
        raise DockerRegistryClient::APIVersionError, "Not recognized"
      end
    end

    def base_uri
      "#{docker_uri.protocol}#{docker_uri.registry}"
    end

  end
end
