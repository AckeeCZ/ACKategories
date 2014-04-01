Pod::Spec.new do |spec|
  spec.name         = 'ACKategories'
  spec.version      = '2.0'
  spec.license = { :type => 'MIT', :text => <<-LICENSE
                   Copyright 2014 Ackee
                 LICENSE
               	    }
  spec.homepage     = 'https://github.com/AckeeCZ/ACKategories'
  spec.authors      =  {'Dominik Vesely' => 'dominik.vesely@ackee.cz' }
  spec.summary      = 'Ackee Categories and Macros'
  spec.source       =  {:git => 'https://github.com/AckeeCZ/ACKategories.git', :tag => 'v2.0' }
  spec.source_files = 'ACKategories/**/*.{m,h}'
  spec.framework    = 'SystemConfiguration'
  spec.requires_arc = true
end