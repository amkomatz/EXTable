
Pod::Spec.new do |spec|

  spec.name         = "EXTable"
  spec.version      = "1.1"
  spec.summary      = "A declarative table view controller."
  spec.homepage     = "https://github.com/amkomatz/EXTable"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = "Austin-Michael Komatz"
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/amkomatz/EXTable.git", :tag => "#{spec.version}" }

  spec.source_files  = "**/*.{swift}"
  spec.exclude_files = "Classes/Exclude"
end
