import PackageDescription

let package = Package(
    name: "CPFCNPJTools",  // Nome do pacote, deve ser o mesmo usado no CocoaPods
    platforms: [
        .iOS(.v9),  // Versão mínima do iOS
    ],
    products: [
        .library(
            name: "CPFCNPJTools",  // Nome da biblioteca que será gerada
            targets: ["CPFCNPJTools"]  // Nome do target
        ),
    ],
    dependencies: [
        // Caso tenha dependências externas, você adiciona aqui
    ],
    targets: [
        .target(
            name: "CPFCNPJTools",  // Nome do target
            dependencies: [],  // Dependências internas ou externas
            path: "Sources",  // Caminho do código fonte
            resources: [
                // Adicionar recursos se necessário
            ]
        ),
        .testTarget(
            name: "CPFCNPJToolsTests",  // Nome do target de testes
            dependencies: ["CPFCNPJTools"],  // Dependência da biblioteca principal
            path: "Tests",  // Caminho dos testes
            resources: [
                // Adicionar recursos de testes, se necessário
            ]
        ),
    ]
)
