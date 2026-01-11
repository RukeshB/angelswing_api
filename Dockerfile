# Use Ruby official image
FROM ruby:3.1

# Install system dependencies
RUN apt-get update -qq && \
    apt-get install -y nodejs yarn postgresql-client build-essential libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy Gemfiles and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of the application
COPY . .

# Expose Rails port
EXPOSE 3000

# Default command to start Rails server
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && rails server -b 0.0.0.0"]
