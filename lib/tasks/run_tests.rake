# frozen_string_literal: true

task tests: [:run_rspec_tests, :run_cucumber_tests]

task run_rspec_tests: :environment do
  sh 'bundle exec rspec -f d'
end

task run_cucumber_tests: :environment do
  sh 'bundle exec cucumber'
end
