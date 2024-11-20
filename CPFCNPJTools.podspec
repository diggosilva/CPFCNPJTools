Pod::Spec.new do |s|
    s.name = 'CPFCNPJTools'
    s.version = '0.1'
    s.license = { :type => 'MIT', :file => 'LICENSE' }
    s.summary = 'CPF and CNPJ Tools'
  
    s.description      = <<-DESC
    It a Swift library that validates CPF and CNPJ.
                         DESC
  
    s.homepage         = 'https://github.com/diggosilva/CPF-CNPJ-TOOLS'
    s.authors = { 'Diggo Silva' => 'rdiggosilva@gmail.com', 'Helio Mesquita' => 'helio.mesquitaios@gmail.com'  }
    s.source = { :git => 'https://github.com/diggosilva/CPF-CNPJ-TOOLS', :tag => s.version }
    s.ios.deployment_target = '13.0'
    s.source_files = 'CPFCNPJTools/Source/*.swift'
    s.test_spec 'Tests' do |test_spec|
      test_spec.source_files = 'CPFCNPJTools/Tests/*.swift'
    end 
  end