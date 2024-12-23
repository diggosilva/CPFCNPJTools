Pod::Spec.new do |s|
    s.name = 'CPFCNPJTools'
    s.version = '2.0.0'
    s.license = { :type => 'MIT', :file => 'LICENSE' }
    s.summary = 'CPF and CNPJ Tools'
    s.swift_versions = '5.0'
  
    s.description      = <<-DESC
    CPF and CNPJ Validator for iOS helps validate CPF and CNPJ numbers in your app according to Brazilian Federal Revenue rules.
    It supports both punctuated and unpunctuated formats.
    Easily integrate accurate CPF and CNPJ validation without coding from scratch.
    The Alphanumeric CNPJ will be assigned, starting in July 2026, exclusively to new registrations.
    Existing CNPJ numbers will not undergo any change, that is, those who are already registered with the CNPJ will keep their number valid!
    
    Validador de CPF e CNPJ para iOS valida números conforme as regras da Receita Federal.
    Suporta formatos com ou sem pontuação.
    Integre facilmente a validação de CPF e CNPJ sem escrever lógica de validação.
    O CNPJ Alfanumérico será atribuído, a partir de julho de 2026, exclusivamente para novos registros.
    Os números de CNPJ existentes não sofrerão nenhuma alteração, ou seja, quem já está registrado no CNPJ manterá seu número válido!
                         DESC
  
    s.homepage         = 'https://github.com/diggosilva/CPFCNPJTools'
    s.authors = { 'Diggo Silva' => 'rdiggosilva@gmail.com', 'Helio Mesquita' => 'helio.mesquitaios@gmail.com'  }
    s.source = { :git => 'https://github.com/diggosilva/CPFCNPJTools.git', :tag => s.version }
    s.ios.deployment_target = '13.0'
    s.source_files = 'CPFCNPJTools/Source/*.swift'
    s.test_spec 'Tests' do |test_spec|
      test_spec.source_files = 'CPFCNPJTools/Tests/*.swift'
    end 
  end
