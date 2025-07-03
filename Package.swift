// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "NP2iOS",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "NP2iOS",
            targets: ["NP2iOS"]
        ),
    ],
    dependencies: [
        // SDL2 Swift Package
        .package(url: "https://github.com/ctreffs/SwiftSDL2.git", from: "1.4.0")
    ],
    targets: [
        .target(
            name: "NP2iOS",
            dependencies: [
                .product(name: "SDL2", package: "SwiftSDL2")
            ],
            path: "sdl2",
            exclude: [
                "win32",
                "x11",
                "MacOSX"
            ],
            sources: [
                "iOS/main.m",
                "iOS/ios-super-turbo.m",
                "iOS/KeyMapper.m",
                "iOS/MfiGameControllerHandler.m",
                "iOS/GameControllerKeyRemapController.m",
                "iOS/KeyCapView.m",
                "np2.c",
                "dosio.c",
                "fontmng.c",
                "inputmng.c",
                "scrnmng.c",
                "soundmng.cpp",
                "sysmng.c",
                "taskmng.c",
                "sdlkbd.c",
                "mousemng.c",
                "joymng.c",
                "ini.c",
                "sysmenu.c",
                "timemng.c",
                "trace.c"
            ],
            resources: [
                .copy("iOS/Default-568h@2x.png"),
                .copy("iOS/Default-Landscape.png"),
                .copy("iOS/Default.png"),
                .copy("iOS/Icon-72.png"),
                .copy("iOS/Icon.png"),
                .copy("font.tmp")
            ],
            publicHeadersPath: "iOS/SDL2/include",
            cSettings: [
                .headerSearchPath("iOS"),
                .headerSearchPath("iOS/SDL2/include"),
                .headerSearchPath("../"),
                .headerSearchPath("../bios"),
                .headerSearchPath("../cbus"),
                .headerSearchPath("../codecnv"),
                .headerSearchPath("../common"),
                .headerSearchPath("../embed"),
                .headerSearchPath("../fdd"),
                .headerSearchPath("../font"),
                .headerSearchPath("../generic"),
                .headerSearchPath("../i286c"),
                .headerSearchPath("../io"),
                .headerSearchPath("../lio"),
                .headerSearchPath("../mem"),
                .headerSearchPath("../sound"),
                .headerSearchPath("../trap"),
                .headerSearchPath("../vram"),
                .headerSearchPath("../zlib"),
                .define("IOS"),
                .define("NP2_SDL2")
            ],
            linkerSettings: [
                .linkedFramework("UIKit"),
                .linkedFramework("Foundation"),
                .linkedFramework("OpenGLES"),
                .linkedFramework("QuartzCore"),
                .linkedFramework("GameController"),
                .linkedFramework("CoreMotion"),
                .linkedFramework("AVFoundation")
            ]
        )
    ]
)