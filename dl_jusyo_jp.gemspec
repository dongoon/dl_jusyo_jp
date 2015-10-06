# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dl_jusyo_jp/version'

Gem::Specification.new do |spec|
  spec.name          = "dl_jusyo_jp"
  spec.version       = DlJusyoJp::VERSION
  spec.authors       = ["Yasuhiko Maeda"]
  spec.email         = ["y.maeda@dongoon.jp"]

  spec.summary       = %q{住所.jpから住所情報をダウンロードしてRailsで使いやすいようにする}
  spec.description   = %q{住所.jp<http://jusyo.jp/>が提供してくださっている住所情報をダウンロードしてモデルのデータとしてインポートするrakeを提供します}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sqlite3-ruby"

  spec.add_runtime_dependency "rubyzip"
  spec.add_runtime_dependency "activerecord"
end
