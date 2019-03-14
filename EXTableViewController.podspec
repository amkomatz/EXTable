
Pod::Spec.new do |spec|

  spec.name         = "EXTableViewController"
  spec.version      = "0.0.3"
  spec.summary      = "Declarative table view controller."
  spec.homepage     = "https://github.com/amkomatz/EXTableViewController"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = "Austin-Michael Komatz"
  spec.platform     = :ios, "12.0"
  spec.swift_version = "4.2"
  spec.source       = { :git => "https://github.com/amkomatz/EXTableViewController.git", :tag => "#{spec.version}" }

  spec.source_files  = "**/*.{swift}"
  spec.exclude_files = "Classes/Exclude"
end
