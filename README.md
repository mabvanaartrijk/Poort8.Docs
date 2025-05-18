# Poort8.Keyper.Docs

## Setting up the Devcontainer

To set up the devcontainer for building and testing this repository in GitHub Codespaces, follow these steps:

1. Create a new directory named `.devcontainer` if it doesn't already exist.
2. Add a new file named `devcontainer.json` inside the `.devcontainer` directory with the following content:
   ```json
   {
     "name": "Poort8 Docs",
     "image": "mcr.microsoft.com/devcontainers/ruby:3.3",
     "features": {
       "ghcr.io/devcontainers/features/ruby:1": {
         "version": "3.3.0"
       }
     },
     "postCreateCommand": "bundle install --jobs 4 --retry 3",
     "customizations": {
       "vscode": {
         "extensions": [
           "rebornix.Ruby"
         ]
       }
     },
     "tasks": {
       "test": "bundle exec htmlproofer ./_site --disable-external",
       "build": "bundle exec jekyll build --trace"
     }
   }
   ```
3. Ensure that the `Gemfile` includes the necessary dependencies for testing, as already specified in `Gemfile`.
4. Verify that the devcontainer setup works by opening the repository in GitHub Codespaces and running the build and test tasks.

## Running the CI Workflow

To run the CI workflow for this repository, follow these steps:

1. Ensure that the `.github/workflows/ci.yml` file is present with the following content:
   ```yaml
   name: CI
   on: [push, pull_request]
   jobs:
     build:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v4
         - uses: ruby/setup-ruby@v1
           with: { ruby-version: '3.3' }
         - run: bundle install --jobs 4 --retry 3
         - run: bundle exec jekyll build --trace
         - run: bundle exec htmlproofer ./_site --disable-external
   ```
2. Ensure that the `Gemfile` includes the necessary dependencies for testing under the `:test` group:
   ```ruby
   group :test do
     gem "rspec", "~> 3.12"
     gem "capybara", "~> 3.39"
     gem "webrick", "~> 1.8"
   end
   ```
3. Push your changes to the repository or create a pull request. The CI workflow will automatically run on push and pull request events.
4. Verify that the CI workflow runs successfully and that the build and tests pass without errors.

## Recommendations for Improving Development Experience and Performance

To improve the development experience and performance of the Jekyll site, consider the following recommendations:

1. Add the `--incremental` flag during development to speed up builds by only regenerating files that have changed.
2. Run the `--profile` flag once to pinpoint bottlenecks in the build process and identify areas for optimization.
3. Consider disabling unnecessary plugins during development by creating a `_config.dev.yml` file and using the `JEKYLL_ENV=development` environment variable to speed up the build process.
