#
# Be sure to run `pod lib lint StringStylizer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "StringStylizer"
  s.version          = "4.1.0"
  s.summary          = "Type strict builder class for NSAttributedString."

  s.description      = <<-DESC
  StringStylizer makes NSAttributedString more intuitive with Method chain and Operator. Building NSAttributedString is so difficult that it requires us to remember attribute names and types. If you do that with StringStylizer, There is no need to remember them.
                       DESC

  s.homepage         = "https://github.com/kazuhiro4949/StringStylizer"
  s.license          = 'MIT'
  s.author           = { "Kazuhiro Hayashi" => "k.hayashi.info@gmail.com" }
  s.source           = { :git => "https://github.com/kazuhiro4949/StringStylizer.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'StringStylizer/*'
end
