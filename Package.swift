import PackageDescription

let package = Package(
    name: "KituraBotMessageStore",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 1),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 1),
        .Package(url: "https://github.com/JacopoMangiavacchi/KituraBot.git", majorVersion: 0)
    ]
)
