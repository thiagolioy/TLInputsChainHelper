#
# Be sure to run `pod lib lint TLInputsChainHelper.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TLInputsChainHelper"
  s.version          = "0.1.4"
  s.summary          = "Chain your textfields and handle interaction and focus with TLInputsChainHelper."
  s.homepage         = "https://github.com/thiagolioy/TLInputsChainHelper"
  s.license          = 'MIT'
  s.author           = { "Thiago Lioy" => "lioyufrj@gmail.com" }
  s.source           = { :git => "https://github.com/thiagolioy/TLInputsChainHelper.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/tplioy'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'TLInputsChainHelper' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
end
