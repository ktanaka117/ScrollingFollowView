Pod::Spec.new do |s|

  s.name         = "ScrollingFollowView"
  s.version      = "1.0.0"
  s.summary      = "A simple view follows scrolling."
  s.description  = <<-DESC
                   A simple view follows scrolling.
                   More information is coming soon...
                   DESC

  s.homepage     = "https://github.com/ktanaka117/ScrollingFollowView"
  s.license      = "MIT"
  s.author             = { "Kenji Tanaka" => "key_m4096_kung_fu@yahoo.co.jp" }
  s.social_media_url   = "http://twitter.com/ktanaka117"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/ktanaka117/ScrollingFollowView.git", :tag => s.version.to_s }

  s.source_files  = "ScrollingFollowView/**/*.swift"
  
end
