# frozen_string_literal: true

class Application < Roda
  def self.root
    File.expand_path('..', __dir__)
  end

  plugin :environments
  plugin :error_handler
  plugin :hash_routes
  plugin :json_parser
  plugin :default_headers,
         'Content-Type' => 'application/json',
         'X-Frame-Options' => 'deny',
         'X-Content-Type-Options' => 'nosniff',
         'X-XSS-Protection' => '1; mode=block'
  plugin(:not_found) { not_found_response }
  plugin :json_parser
  plugin :hooks
  include Errors
  include Validations
  include ApiErrors

  route do |r|
    r.root do
      { status: 'ok' }.to_json
    end
  end

  private

  def params
    request.params
  end
end
