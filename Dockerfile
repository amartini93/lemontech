# Dockerfile
FROM ruby:3.3.3

# Set up environment
ENV RAILS_ENV=development

# Install dependencies
RUN apt-get update && \
    apt-get install -y build-essential nodejs yarn && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install bundler and gems
RUN gem install bundler:2.3.5 && bundle install --jobs 20 --retry 5

# Copy application code
COPY . .

# Start Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
