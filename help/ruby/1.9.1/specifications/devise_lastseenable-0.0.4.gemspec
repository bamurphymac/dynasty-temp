# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{devise_lastseenable}
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{ctide}]
  s.date = %q{2011-09-01}
  s.description = %q{This ensures that devise will update a last_seen flag on the model whenever you check if a user is authed.}
  s.email = %q{christide@christide.com}
  s.extra_rdoc_files = [%q{LICENSE.txt}, %q{README.rdoc}]
  s.files = [%q{LICENSE.txt}, %q{README.rdoc}]
  s.homepage = %q{http://github.com/ctide/devise_lastseenable}
  s.licenses = [%q{MIT}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{This ensures that devise will update a last_seen flag on the model whenever you check if a user is authed.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.0.4"])
      s.add_runtime_dependency(%q<warden>, [">= 0"])
      s.add_runtime_dependency(%q<devise>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_runtime_dependency(%q<warden>, [">= 0"])
      s.add_runtime_dependency(%q<devise>, [">= 0"])
      s.add_runtime_dependency(%q<rails>, [">= 3.0.4"])
    else
      s.add_dependency(%q<rails>, [">= 3.0.4"])
      s.add_dependency(%q<warden>, [">= 0"])
      s.add_dependency(%q<devise>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<warden>, [">= 0"])
      s.add_dependency(%q<devise>, [">= 0"])
      s.add_dependency(%q<rails>, [">= 3.0.4"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.0.4"])
    s.add_dependency(%q<warden>, [">= 0"])
    s.add_dependency(%q<devise>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<warden>, [">= 0"])
    s.add_dependency(%q<devise>, [">= 0"])
    s.add_dependency(%q<rails>, [">= 3.0.4"])
  end
end
