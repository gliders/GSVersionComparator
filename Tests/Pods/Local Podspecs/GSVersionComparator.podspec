Pod::Spec.new do |s|
  s.name             = "GSVersionComparator"
  s.version          = "0.2.0"
  s.summary          = "A port of Apache Maven's ComparableVersion to Obj-C."
  s.description      = <<-DESC
                       A direct port of org.apache.maven.artifact.versioning.ComparableVersion from the Apache Maven Project
                       to Objective-C.
                       DESC
  s.homepage         = "https://github.com/gliders/GSVersionComparator"
  s.license          = 'Apache v2'
  s.author           = { "Ryan Brignoni" => "castral01@gmail.com" }
  s.source           = { :git => "https://github.com/gliders/GSVersionComparator.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/RyanBrignoni'

  s.requires_arc = true

  s.source_files = 'GSVersionComparator'
  s.public_header_files = 'GSVersionComparator/**/*.h'
end
