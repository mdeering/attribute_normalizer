require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'

begin
  GEM = "attribute_normalizer"
  AUTHOR = "Michael Deering"
  EMAIL = "mdeering@mdeering.com"
  SUMMARY = "Active Record attribute normalizer that excepts code blocks."
  HOMEPAGE = "http://github.com/mdeering/attribute_normalizer/tree/master"
  
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = GEM
    s.summary = SUMMARY
    s.email = EMAIL
    s.homepage = HOMEPAGE
    s.description = SUMMARY
    s.author = AUTHOR
    
    s.require_path = 'lib'
    s.autorequire = GEM
    s.files = %w(MIT-LICENSE README.textile Rakefile) + Dir.glob("{rails,lib,spec}/**/*")
  end
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

desc 'Default: spec tests.'
task :default => :spec

desc 'Test the attribute_normalizer plugin.'
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ["-c"]
end

desc "Run all examples with RCov"
Spec::Rake::SpecTask.new('examples_with_rcov') do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec,Library']
end

desc 'Generate documentation for the attribute_normalizer plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'AttributeNormalizer'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
