require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'

begin
  AUTHOR   = "Michael Deering"
  EMAIL    = "mdeering@mdeering.com"
  GEM      = "attribute_normalizer"
  HOMEPAGE = "http://github.com/mdeering/attribute_normalizer"
  SUMMARY  = "Attribute normalizer that excepts code blocks."

  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.author       = AUTHOR
    s.email        = EMAIL
    s.files        = %w(install.rb install.txt MIT-LICENSE README.textile Rakefile) + Dir.glob("{rails,lib,spec}/**/*")
    s.homepage     = HOMEPAGE
    s.name         = GEM
    s.require_path = 'lib'
    s.summary      = SUMMARY
    s.post_install_message = %q[
-----------------------------------------------------------------------
  Attribute Normalizer News:

  There are lots of changes from the 0.1.2 release to the 0.2.0 release!
  Change log is here http://github.com/mdeering/attribute_normalizer/blob/master/ROADMAP.textile
  Docs have been updated here http://github.com/mdeering/attribute_normalizer

  Cheers,
  Michael Deering http://mdeering.com
-----------------------------------------------------------------------
    ]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install jeweler"
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
  t.rcov_opts = ['--exclude', '/opt,spec,Library']
end

desc 'Generate documentation for the attribute_normalizer plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'AttributeNormalizer'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.textile')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
