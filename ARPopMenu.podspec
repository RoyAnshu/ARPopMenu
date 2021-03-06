Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "ARPopMenu"
s.summary = "ARPopMenu lets a user to create Menu popup."
#s.requires_arc = true

# 2
s.version = "1.1"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Anshu" => "iosdeveloperanshu@gmail.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/RoyAnshu/ARPopMenu"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/RoyAnshu/ARPopMenu.git", 
             :tag => "#{s.version}" }

# 7
s.framework = "UIKit"

# 8
s.source_files = 'ARPopMenu/*.{h,m}'





end
