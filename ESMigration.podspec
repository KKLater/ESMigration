Pod::Spec.new do |s|

  s.name         = "ESMigration"
  s.version      = "0.0.1"
  s.summary      = "Migration or update with Swift for mac、ios、watchos、tvos."

  s.description  = <<-DESC
                     ESMigration is a simple and pure Swift implemented library for migration or update datas when App updated version.
                   DESC

  s.homepage     = "https://github.com/KKLater/ESMigration"
  # s.screenshots  = ""

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.authors      = { "KKLater" => "lshxin89@126.com" }

  s.swift_version = "5.0"
  s.swift_versions = ['5.0']

  s.ios.deployment_target = "10.0"
  s.tvos.deployment_target = "10.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "3.0"

  s.source       = { :git => "https://github.com/KKLater/ESMigration.git", :tag => s.version }

  s.source_files  = ["Sources/**/*.swift", "Sources/ESMigration.h"]
  s.requires_arc = true
end
