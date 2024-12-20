# Dockerfile
FROM ruby:3.1.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs sqlite3

# Set up the working directory
WORKDIR /app

# Install Bundler
RUN gem install bundler

# Copy Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the application
COPY . .

# Precompile assets for production (optional for development)
RUN rails assets:precompile

# Expose the port the app runs on
EXPOSE 3000

# Run the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
