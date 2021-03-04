# frozen_string_literal: true

class Application < Roda
  def self.root
    File.expand_path('..', __dir__)
  end

  plugin :environments
  plugin :hash_routes
  plugin :json_parser
  plugin :default_headers,
         'Content-Type' => 'text/html',
         'X-Frame-Options' => 'deny',
         'X-Content-Type-Options' => 'nosniff',
         'X-XSS-Protection' => '1; mode=block'
  plugin(:not_found) { not_found_response }
  plugin :render,
         engine: 'slim',
         layout: 'layouts/layout',
         views: Application.root.concat('/app/views')
  plugin :hooks
  include Errors

  hash_branch('tasks') do |r|
    r.run TasksRoute
  end

  route do |r|
    r.root do
      r.redirect 'tasks'
    end

    r.hash_branches
  end

  private

  def params
    request.params
  end
end
