# CPFCNPJTools - 🇧🇷

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.9.1-orange.svg" />
    <img src="https://img.shields.io/badge/Xcode-15.2.X-orange.svg" />
    <img src="https://img.shields.io/badge/platforms-iOS-brightgreen.svg?style=flat" alt="iOS" />
    <a href="https://www.linkedin.com/in/rodrigo-silva-6a53ba300/" target="_blank">
        <img src="https://img.shields.io/badge/LinkedIn-@RodrigoSilva-blue.svg?style=flat" alt="LinkedIn: @RodrigoSilva" />
    </a>
</p>

Uma biblioteca iOS escrita em Swift para validação, geração e máscara automática de números de CPF e CNPJ (incluindo o novo padrão Alfanumérico 2026).

## O que há de novo?

- **A partir de julho de 2026**, a Receita Federal implementará o **CNPJ Alfanumérico**. Esta biblioteca já está preparada para validar tanto o formato antigo quanto o novo de forma híbrida.

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

- [x] **Validação Híbrida:** Identifica e valida CPF ou CNPJ automaticamente.
- [x] **Suporte Alfanumérico:** Preparada para o novo padrão de CNPJ 2026.
- [x] **Máscara Inteligente:** Aplica a pontuação correta (CPF ou CNPJ) em tempo real conforme o tamanho do texto.
- [x] **Geração de Dados:** Gera CPFs e CNPJs (Numéricos e Alfanuméricos) para testes.

## Instalação
**SPM (Swift Package Manager)**
No Xcode, vá em `File -> Add Package Dependencies` e insira a URL: https://github.com/diggosilva/CPFCNPJTools

## Como Usar

# 1. Validação e Máscara Dual (Recomendado)

- O `CNPJDualFormatManager` é a forma mais simples de lidar com campos que aceitam tanto CPF quanto CNPJ.

```swift
let manager = CNPJDualFormatManager()

// Validação Inteligente
let status = manager.validate(cnpjDualFormat: "111.444.777-35") // .valid
let status2 = manager.validate(cnpjDualFormat: "12.ABC.345/01DE-35") // .valid

// Máscara Automática (Ideal para TextField)
let maskedCPF = manager.mask(cnpjDualFormat: "11144477735") // "111.444.777-35"
let maskedCNPJ = manager.mask(cnpjDualFormat: "12ABC34501DE35") // "12.ABC.345/01DE-35"
 ```

# 2. Geração de Dados Fictícios

```swift
let manager = CNPJDualFormatManager()
let newCNPJ = manager.generate() // Retorna um CNPJ Alfanumérico válido formatado
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

A Swift iOS library for validation, generation, and automatic masking of CPF and CNPJ numbers (including the new 2026 Alphanumeric standard).

## What's new?

- **Starting in July 2026**, the Brazilian Federal Revenue will implement the **Alphanumeric CNPJ**. This library is already prepared to validate both the old and the new formats seamlessly.

## Content

- [Requisitos](#requisitos)
- [Funcionalidades](#funcionalidades)
- [Instalação](#instalacao)
- [Como Usar](#como-usar)
- [Créditos](#creditos)

## Required

- iOS 17.0+
- Xcode 15.0+
- Swift 5.0+

## Functionalities

- [x] **Hybrid Validation:** Automatically identifies and validates CPF or CNPJ.
- [x] **Alphanumeric Support:** Ready for the new 2026 CNPJ standard.
- [x] **Smart Masking:** Applies the correct formatting (CPF or CNPJ) in real-time based on input length.
- [x] **Data Generation:** Generates valid CPFs and CNPJs (Numeric and Alphanumeric) for testing.

## Instalação
**SPM (Swift Package Manager)**
No Xcode, vá em `File -> Add Package Dependencies` e insira a URL: https://github.com/diggosilva/CPFCNPJTools

## How to Use

# 1. Dual Validation and Masking (Recommended)

- `CNPJDualFormatManager` is the easiest way to handle fields that accept both CPF and CNPJ.

```swift
let manager = CNPJDualFormatManager()

// Smart Validation
let status = manager.validate(cnpjDualFormat: "111.444.777-35") // .valid
let status2 = manager.validate(cnpjDualFormat: "12.ABC.345/01DE-35") // .valid

// Automatic Masking (Perfect for TextFields)
let maskedCPF = manager.mask(cnpjDualFormat: "11144477735") // "111.444.777-35"
let maskedCNPJ = manager.mask(cnpjDualFormat: "12ABC34501DE35") // "12.ABC.345/01DE-35"
 ```

# 2. Fake Data Generation

```swift
let manager = CNPJDualFormatManager()
let newCNPJ = manager.generate() // Returns a valid formatted Alphanumeric CNPJ
 ```

# Notes:

- The file is formatted in Markdown (.md), which is the standard for GitHub readme files.

- The methods are clearly described, with code examples in Swift to show how to use the library.

- The explanations and comments are all in English, making the documentation accessible to a wider audience.

- Feel free to tweak any parts of the documentation to fit your style or add any additional information that you think is important!

- If you'd like any more changes or additions, let me know.

# Credits

- **Diggo Silva**
- **Helio Mesquita**

```
```
