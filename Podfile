install! 'cocoapods', :warn_for_unused_master_specs_repo => false
platform :ios, '15.0'

project 'Example.xcodeproj'

target 'ExampleApp' do
    use_frameworks!

    pod 'CPFCNPJTools', :path => './CPFCNPJTools.podspec', :testspecs => ['Tests'] 
end