Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Allow from all
    origins "*"

    resource "*",
             headers: :any,
             methods: %i[get post put patch delete options head],
             expose: %w[Content-Rage Retry-After Grpc-Message Grpc-Status]
  end
end
