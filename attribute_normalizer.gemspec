# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "attribute_normalizer/version"

Gem::Specification.new do |s|
  s.name = %q{attribute_normalizer}
  s.version =AttributeNormalizer::VERSION

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Deering"]
  s.date = %q{2011-07-28}
  s.email = %q{mdeering@mdeering.com}
  s.extra_rdoc_files = [
    "README.textile"
  ]
  s.files = [
    "MIT-LICENSE",
     "README.textile",
     "Rakefile",
     "install.rb",
     "install.txt",
     "lib/attribute_normalizer.rb",
     "lib/attribute_normalizer/model_inclusions.rb",
     "lib/attribute_normalizer/normalizers/blank_normalizer.rb",
     "lib/attribute_normalizer/normalizers/phone_normalizer.rb",
     "lib/attribute_normalizer/normalizers/squish_normalizer.rb",
     "lib/attribute_normalizer/normalizers/strip_normalizer.rb",
     "lib/attribute_normalizer/rspec_matcher.rb",
     "rails/init.rb",
     "spec/article_spec.rb",
     "spec/attribute_normalizer_spec.rb",
     "spec/author_spec.rb",
     "spec/book_spec.rb",
     "spec/connection_and_schema.rb",
     "spec/journal_spec.rb",
     "spec/models/article.rb",
     "spec/models/author.rb",
     "spec/models/book.rb",
     "spec/models/journal.rb",
     "spec/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/mdeering/attribute_normalizer}

  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{Attribute normalizer that excepts code blocks.}
  s.test_files = [
    "spec/article_spec.rb",
     "spec/attribute_normalizer_spec.rb",
     "spec/author_spec.rb",
     "spec/book_spec.rb",
     "spec/connection_and_schema.rb",
     "spec/journal_spec.rb",
     "spec/models/article.rb",
     "spec/models/author.rb",
     "spec/models/book.rb",
     "spec/models/journal.rb",
     "spec/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end