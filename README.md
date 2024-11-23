# CPF-CNPJ-TOOLS

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.9.1-orange.svg" />
    <img src="https://img.shields.io/badge/Xcode-15.2.X-orange.svg" />
    <img src="https://img.shields.io/badge/platforms-iOS-brightgreen.svg?style=flat" alt="iOS" />
    <a href="https://www.linkedin.com/in/rodrigo-silva-6a53ba300/" target="_blank">
        <img src="https://img.shields.io/badge/LinkedIn-@RodrigoSilva-blue.svg?style=flat" alt="LinkedIn: @RodrigoSilva" />
    </a>
</p>

A iOS application written in Swift, This project is a library for CocoaPods that allows you to validate, generate and manipulate CPF and CNPJ numbers in a simple and efficient way. Ideal for testing and filling out forms.

## Difference between CPF and CNPJ

- CPF (Individual Taxpayer Registry): The CPF is an individual registration number used by the Brazilian Federal Revenue Service to identify an individual. The CPF is made up of 11 digits (XXX.XXX.XXX-XX). It is used for various purposes, such as opening bank accounts, issuing invoices, and filing taxes.

- CNPJ (National Registry of Legal Entities): The CNPJ is a registration number used by the Brazilian Federal Revenue Service to identify companies or other legal entities. The CNPJ is made up of 14 digits (XX.XXX.XXX/0001-XX). It is used to formalize the existence of a company, allowing it to carry out commercial activities, such as issuing invoices, paying taxes, among others.

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
- [x] Fictitious CPF generation: Generate a valid CPF number randomly.
- [x] Fictitious CNPJ generation: Generate a valid CNPJ number randomly.

## Instalation

Add the dependency to your Podfile:

```sh
$ pod 'CPFCNPJTools'
```

Then run:

```sh
$ pod install
```

## How to use

## 1.1 Validate CPF

- To validate a CPF, simply use the ```validate(cpf:)``` method:

```swift
let validator = CPFValidator()
let result = validator.validate(cpf: "11144477735")
print(result) // .valid or .invalid
 ```

## 1.2 Generate Fake CPF

 - To generate a fake CPF, simply use the ```generateFakeCPF()``` method:

 ```swift
 let validator = CPFValidator()
 let fakeCPF = validator.generateFakeCPF()
 print(fakeCPF) // "11144477735"
```

## 1.3 Generate Fake CPF masked

- To generate a fake CPF with mask, simply use the ```generateFakeCPFMasked()``` method:

```swift
let validator = CPFValidator()
let fakeCPFMasked = validator.generateFakeCPFMasked()
print(fakeCPFMasked) // "111.444.777-35"
```
## 2.1 Validate CNPJ

- To validate a CNPJ, simply use the ```validate(cnpj:)``` method:

```swift
let validator = CNPJValidator()
let result = validator.validate(cnpj: "11444777000135")
print(result) // .valid or .invalid
```

## 2.2 Generate Fake CNPJ

```swift
let validator = CNPJValidator()
let fakeCNPJ = validator.generateFakeCNPJ()
print(fakeCNPJ) // "11444777000135"
```

## 2.3 Generate Fake CNPJ masked

```swift
let validator = CNPJValidator()
let fakeCNPJMasked = validator.generateFakeCNPJMasked()
print(fakeCNPJMasked) // "11.444.777/0001-35"
```

### Notes:

- The file is formatted in **Markdown** (`.md`), which is the standard for GitHub readme files.
- The methods are clearly described, with code examples in Swift to show how to use the library.
- The explanations and comments are all in English, making the documentation accessible to a wider audience.

Feel free to tweak any parts of the documentation to fit your style or add any additional information that you think is important! 

If you'd like any more changes or additions, let me know.


## Credits

- Diggo Silva
- Helio Mesquita
