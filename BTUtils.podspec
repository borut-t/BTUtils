Pod::Spec.new do |s|
  s.name         = 'BTUtils'
  s.version      = '1.0'
  s.summary      = 'Usable utility methods and categories.'
  s.homepage     = 'https://github.com/borut-t/BTUtils'
  s.license      = { :type => 'zlib', :file => 'LICENCE.md' }
  s.author       = 'Borut Tomažin'
  s.platform     = :ios, '5.0'
  s.source       = { :git => 'https://github.com/borut-t/BTUtils.git', :tag => '1.0' }
  s.source_files = 'BTUtils/BTStoreView.{h,m}'
  s.dependency   = 'Reachability', '~> 3.1.1'
  s.frameworks   = 'UIKit'
  s.requires_arc = true
end
