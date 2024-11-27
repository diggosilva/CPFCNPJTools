Pod::Spec.new do |s|
    s.name = 'CPFCNPJTools'
    s.version = '1.0.0'
    s.license = { :type => 'MIT', :file => 'LICENSE' }
    s.summary = 'CPF and CNPJ Tools'
  
    s.description      = <<-DESC
    CPF and CNPJ Validator for iOS helps validate CPF and CNPJ numbers in your app according to Brazilian Federal Revenue rules.
    \nIt supports both punctuated and unpunctuated formats.
    \nEasily integrate accurate CPF and CNPJ validation without coding from scratch.
    
    \n\nValidador de CPF e CNPJ para iOS valida números conforme as regras da Receita Federal.
    \nSuporta formatos com ou sem pontuação.
    \nIntegre facilmente a validação de CPF e CNPJ sem escrever lógica de validação.
                         DESC
  
    s.homepage         = 'https://github.com/diggosilva/CPFCNPJTools'
    s.authors = { 'Diggo Silva' => 'rdiggosilva@gmail.com', 'Helio Mesquita' => 'helio.mesquitaios@gmail.com'  }
    s.source = { :git => 'https://github.com/diggosilva/CPFCNPJTools', :tag => s.version }
    s.ios.deployment_target = '13.0'
    s.source_files = 'CPFCNPJTools/Source/*.swift'
    s.test_spec 'Tests' do |test_spec|
      test_spec.source_files = 'CPFCNPJTools/Tests/*.swift'
    end 
  end
