# CPFCNPJTools - 🇧🇷

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.9.1-orange.svg" />
    <img src="https://img.shields.io/badge/Xcode-15.2.X-orange.svg" />
    <img src="https://img.shields.io/badge/platforms-iOS-brightgreen.svg?style=flat" alt="iOS" />
    <a href="https://www.linkedin.com/in/rodrigo-silva-6a53ba300/" target="_blank">
        <img src="https://img.shields.io/badge/LinkedIn-@RodrigoSilva-blue.svg?style=flat" alt="LinkedIn: @RodrigoSilva" />
    </a>
</p>

Uma biblioteca iOS escrita em Swift para validação, geração e manipulação de números de CPF e CNPJ de forma simples e eficiente. Ideal para testes e preenchimento de formulários.

## Diferença entre CPF, CNPJ e CNPJ Alfanumérico

- **CPF (Cadastro de Pessoas Físicas):** O CPF é o número de registro individual utilizado pela Receita Federal para identificar pessoas físicas. É composto por 11 dígitos (XXX.XXX.XXX-XX).

- **CNPJ (Cadastro Nacional da Pessoa Jurídica):** O CNPJ é o número utilizado para identificar empresas e outras entidades jurídicas. É composto por 14 dígitos (XX.XXX.XXX/0001-XX).

- **CNPJ Alfanumérico:** Devido ao crescimento do número de empresas e à futura escassez de combinações puramente numéricas, a Receita Federal implementará o **CNPJ Alfanumérico**.

- O **CNPJ Alfanumérico será atribuído a partir de julho de 2026**, exclusivamente para novos registros. Números de CNPJ já existentes **não sofrerão alterações**.

## Conteúdo

- [Requisitos](#requisitos)
- [Funcionalidades](#funcionalidades)
- [Instalação](#instalacao)
- [Como Usar](#como-usar)
- [Créditos](#creditos)

## Requisitos

- iOS 17.0+
- Xcode 15.0+
- Swift 5.0+

## Funcionalidades

- [x] **Validação de CPF:** Verifica se um CPF é válido seguindo as regras da Receita Federal.
- [x] **Validação de CNPJ:** Verifica se um CNPJ é válido de acordo com as regras fiscais.
- [x] **Validação de CNPJ Alfanumérico:** Verifica se o novo formato alfanumérico é válido.
- [x] **Geração de CPF Fictício:** Gera um CPF válido aleatoriamente.
- [x] **Geração de CNPJ Fictício:** Gera um CNPJ válido aleatoriamente.
- [x] **Geração de CNPJ Alfanumérico Fictício:** Gera um CNPJ Alfanumérico válido aleatoriamente.

## Instalação com CocoaPods

Adicione ao seu Podfile:

```sh
$ pod 'CPFCNPJTools'
```

Então rode:

```sh
$ pod install
```

## Instalação com SPM (Swift Package Manager) (Xcode 11+)
No Xcode, vá em File -> Add Package Dependencies e insira a URL: https://github.com/diggosilva/CPFCNPJTools.

## Como Usar

# 1. CPF

### 1.1 Validar CPF

- Para validar um CPF, simplesmente use o método `validate(cpf: String) -> CPFStatus`:

```swift
let cpfManager = CPFManager()
let status = cpfManager.validate(cpf: "11144477735")
print(status) // .valid, .invalid, .cpfNull, .equalDigits or .invalidFormat
 ```

### 1.2 Gerar CPF falso mascarado

- Para gerar um CPF falso com máscara, simplemente use o método`generateMasked()`:

```swift
let cpfManager = CPFManager()
let fakeCPFMasked = cpfManager.generateMasked()
print(fakeCPFMasked) // "111.444.777-35"  // Randomly generated CPF
```
# CNPJ

### 2.1 Validar CNPJ

- Para validar um CNPJ, simplesmente use o método `validate(cnpj: String) -> CNPJStatus)`:

```swift
let cnpjManager = CNPJManager()
let status = cnpjManager.validate(cnpj: "11444777000135")
print(status) // .valid, .invalid, .cnpjNull, .equalDigits or .invalidFormat
```

### 2.2 Gerar CNPJ falso mascarado

```swift
let cnpjManager = CNPJManager()
let fakeCNPJMasked = cnpjManager.generateMasked()
print(fakeCNPJMasked) // "11.444.777/0001-35"  // Randomly generated CNPJ
```

# CNPJ Alfanumérico

### 3.1 Validar o formato dual do CNPJ

- Para validar um CNPJ alfanumérico, basta usar o método `validate(cnpjDualFormat: String) -> CNPJDualFormatStatus`:

```swift
let cnpjDualFormatManager = CNPJDualFormatManager()
let status = cnpjDualFormatManager.validate(cnpjDualFormat: "12ABC34501DE35")
print(status) // .valid, .invalid, .cnpjNull, .equalDigits ou .invalidFormat
```

### 3.2 Gerar um CNPJ falso com formato dual mascarado

```swift
let cnpjDualFormatManager = CNPJDualFormatManager()
let fakeCNPJAlphaNum = cnpjDualFormatManager.generate()
print(fakeCNPJAlphaNum) // "12.ABC.345/01DE-35" // CNPJ alfanumérico gerado aleatoriamente
```

# Observações:

- O arquivo está formatado em **Markdown** (`.md`), que é o padrão para arquivos README do GitHub.

- Os métodos são descritos claramente, com exemplos de código em Swift para mostrar como usar a biblioteca.

- As explicações e os comentários estão todos em inglês, tornando a documentação acessível a um público mais amplo.

Sinta-se à vontade para ajustar qualquer parte da documentação ao seu estilo ou adicionar qualquer informação adicional que você considere importante!

Se desejar mais alterações ou adições, entre em contato.

# Créditos

- **Diggo Silva**
- **Helio Mesquita**

```
```





# CPFCNPJTools - 🇺🇸

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.9.1-orange.svg" />
    <img src="https://img.shields.io/badge/Xcode-15.2.X-orange.svg" />
    <img src="https://img.shields.io/badge/platforms-iOS-brightgreen.svg?style=flat" alt="iOS" />
    <a href="https://www.linkedin.com/in/rodrigo-silva-6a53ba300/" target="_blank">
        <img src="https://img.shields.io/badge/LinkedIn-@RodrigoSilva-blue.svg?style=flat" alt="LinkedIn: @RodrigoSilva" />
    </a>
</p>

A iOS application written in Swift, this project is a library for CocoaPods that allows you to validate, generate and manipulate CPF and CNPJ numbers in a simple and efficient way. Ideal for testing and filling out forms.

## Difference between (CPF), (CNPJ) and (CNPJ Alphanumeric)

- CPF (Individual Taxpayer Registry): The CPF is an individual registration number used by the Brazilian Federal Revenue Service to identify an individual. The CPF is made up of 11 digits (XXX.XXX.XXX-XX). It is used for various purposes, such as opening bank accounts, issuing invoices, and filing taxes.

- CNPJ (National Registry of Legal Entities): The CNPJ is a registration number used by the Brazilian Federal Revenue Service to identify companies or other legal entities. The CNPJ is made up of 14 digits (XX.XXX.XXX/0001-XX). It is used to formalize the existence of a company, allowing it to carry out commercial activities, such as issuing invoices, paying taxes, among others.

- In view of the continuous growth in the number of companies and the imminent exhaustion of available CNPJ numbers, the Brazilian Federal Revenue Service is launching the **Alphanumeric CNPJ**. This solution aims to facilitate the identification of all companies and improve the business environment, contributing to the economic and social development of Brazil.

- The **Alphanumeric CNPJ will be assigned, starting in July 2026**, exclusively to new registrations. Existing CNPJ numbers will not undergo any change, that is, **those who are already registered with the CNPJ will keep their number valid!**

## Contents

- [Requirements](#requirements)
- [Functionalities](#functionalities)
- [Instalation](#instalation)
- [How to use](#howToUse)
- [Credits](#credits)

## Requirements

- iOS 17.0 or later
- Xcode 15.0 or later
- Swift 5.0 or later

## Functionalities

- [x] CPF Validation: Check if a CPF number is valid, following the rules of the Federal Revenue Service.
- [x] CNPJ Validation: Check if a CNPJ number is valid, according to tax rules.
- [x] CNPJ Alphanumeric Validation: Check if a CNPJ Alphanumeric is valid, according to tax rules.
- [x] Fake CPF generation: Generate a valid CPF number randomly.
- [x] Fake CNPJ generation: Generate a valid CNPJ number randomly.
- [x] Fake CNPJ Alphanumeric generation: Generate a valid CNPJ Alphanumeric randomly.

## Instalation with Cocoapods

Add the dependency to your Podfile:

```sh
$ pod 'CPFCNPJTools'
```

Then run:

```sh
$ pod install
```

## Instalation with (SPM) - Swift Package Manager (Xcode 11+)

[Swift Package Manager (SPM)](https://www.swift.org/documentation/package-manager) is a tool for managing the distribution of Swift code as well as C-family dependency. From Xcode 11, SwiftPM got natively integrated with Xcode.

CPFCNPJTools support SPM from version 5.1.0. To use SPM, you should use Xcode to open your project. Click `File` -> `Add Package Dependencies`, enter [CPFCNPJTools repo's URL](https://github.com/diggosilva/CPFCNPJTools). 

## HowToUse

# CPF

### 1.1 Validate CPF

- To validate a CPF, simply use the `validate(cpf: String) -> CPFStatus` method:

```swift
let cpfManager = CPFManager()
let status = cpfManager.validate(cpf: "11144477735")
print(status) // .valid, .invalid, .cpfNull, .equalDigits or .invalidFormat
 ```

### 1.2 Generate Fake CPF masked

- To generate a fake CPF with mask, simply use the `generateMasked()` method:

```swift
let cpfManager = CPFManager()
let fakeCPFMasked = cpfManager.generateMasked()
print(fakeCPFMasked) // "111.444.777-35"  // Randomly generated CPF
```

# CNPJ

### 2.1 Validate CNPJ

- To validate a CNPJ, simply use the `validate(cnpj: String) -> CNPJStatus)` method:

```swift
let cnpjManager = CNPJManager()
let status = cnpjManager.validate(cnpj: "11444777000135")
print(status) // .valid, .invalid, .cnpjNull, .equalDigits or .invalidFormat
```

### 2.2 Generate Fake CNPJ masked

```swift
let cnpjManager = CNPJManager()
let fakeCNPJMasked = cnpjManager.generateMasked()
print(fakeCNPJMasked) // "11.444.777/0001-35"  // Randomly generated CNPJ
```

# CNPJ Alphanumeric

### 3.1 Validate CNPJ Dual Format

- To validate a CNPJ Alphanumeric, simply use the `validate(cnpjDualFormat: String) -> CNPJDualFormatStatus` method:

```swift
let cnpjDualFormatManager = CNPJDualFormatManager()
let status = cnpjDualFormatManager.validate(cnpjDualFormat: "12ABC34501DE35")
print(status) // .valid, .invalid, .cnpjNull, .equalDigits or .invalidFormat
```

### 3.2 Generate Fake CNPJ Dual Format masked

```swift
let cnpjDualFormatManager = CNPJDualFormatManager()
let fakeCNPJAlphaNum = cnpjDualFormatManager.generate()
print(fakeCNPJAlphaNum) // "12.ABC.345/01DE-35"  // Randomly generated CNPJ Alphanumeric
```

# Notes:

- The file is formatted in **Markdown** (`.md`), which is the standard for GitHub readme files.
- The methods are clearly described, with code examples in Swift to show how to use the library.
- The explanations and comments are all in English, making the documentation accessible to a wider audience.

Feel free to tweak any parts of the documentation to fit your style or add any additional information that you think is important! 

If you'd like any more changes or additions, let me know.

# Credits

- **Diggo Silva**
- **Helio Mesquita**