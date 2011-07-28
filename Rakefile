require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'
require 'bundler/gem_tasks'

desc 'Default: spec tests.'
task :default => :spec

desc 'Test the attribute_normalizer plugin.'
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ["-c"]
end

