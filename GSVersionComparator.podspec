Pod::Spec.new do |spec|
  spec.name             = "GSVersionComparator"
  spec.version          = "1.0.0"
  spec.summary          = "A port of Apache Maven's ComparableVersion to Obj-C and Swift."
  spec.description      = <<-DESC
                       A direct port of org.apache.maven.artifact.versioning.ComparableVersion from the Apache Maven Project
                       to Objective-C and Swift.
                       DESC
  spec.homepage         = "https://github.com/gliders/GSVersionComparator"
  spec.license          = { :type => 'Apache v2', :file => 'LICENSE'}
  spec.author           = { "Ryan Brignoni" => "castral01@gmail.com" }
  spec.source           = { :git => "https://github.com/gliders/GSVersionComparator.git", :tag => spec.version.to_s }
  spec.social_media_url = 'https://twitter.com/castral01'

  spec.ios.deployment_target = '8.4'
  spec.osx.deployment_target = '10.9'
  spec.source_files = 'GSVersionComparator/**/*.{h,m}'
  spec.public_header_files = 'GSVersionComparator/Headers/Public/*.h'
  spec.private_header_files = 'GSVersionComparator/Headers/Private/*.h'
end
