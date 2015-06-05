#
#  Be sure to run `pod spec lint Calendar.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "Calendar"
  s.version      = "0.1"
  s.summary      = "iOS calendar component written in Swift."
  s.homepage     = "https://github.com/lancy98/Calendar"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }
  s.author             = { "Lancy Norbert Fernandes" => "lancy98@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/lancy98/Calendar.git", :tag => "0.1" }
  s.source_files  = 'Calendar/CalendarKit'
  s.resources = 'Calendar/CalendarKit/*.xib'
  s.requires_arc = true
end
