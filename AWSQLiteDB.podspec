Pod::Spec.new do |s|

  s.name         = "AWSQLiteDB"
  s.version      = "0.1.0"
  s.summary      = "A SQLiteDB wrapper written in Swift 2.0"

  s.description  = <<-DESC
                  AWSQLiteDB is a simple wrapper in Swift 2.0 
                   DESC

  s.homepage     = "https://github.com/adow/AWSQLiteDB"
  s.screenshots  = "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/logo.png"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.authors            = { "adow" => "reynoldqin@gmail.com" }
  s.social_media_url   = "http://twitter.com/reynoldqin"

  s.ios.deployment_target = "8.0"

  s.source       = { :git => "git@github.com:adow/AWSQLiteDB.git", :tag => s.version }
  s.source_files  = ["AWSQLiteDB/SQLiteDB.swift"]
  s.requires_arc = true
  s.framework = "libsqlite3.0"

end
