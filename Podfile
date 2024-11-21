install! 'cocoapods', :warn_for_unused_master_specs_repo => false
platform :ios, '15.0'

project 'Sample.xcodeproj'

target 'SampleApp' do
    use_frameworks!

    pod 'CPFCNPJTools', :path => './CPFCNPJTools.podspec', :testspecs => ['Tests'] 
end