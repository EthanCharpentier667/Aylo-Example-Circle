# AYLO Example: Circle

An example game for [AYLO Engine](https://github.com/EthanCharpentier667/Aylo-Engine): a window with a circle in the
middle. It is written only in Luau, drawn with Vulkan through GLFW, and run by the generic `aylo-runtime` of an engine
release. There is no C++ and no build system here.

This repository is the up-to-date example of the engine: it follows the engine, and shows how a game is made with the
version of the engine named in [`engine-version.txt`](engine-version.txt).

## Play it

Download the zip of your platform from the [latest build](../../releases/latest), unzip it and run:

```sh
./play.sh        # play.bat on Windows
```

It needs a graphics driver with Vulkan support. The builds are not signed, so your system may warn on first start (see
[Shipping your game](https://github.com/EthanCharpentier667/Aylo-Engine/blob/main/manual/pages/shipping.md)).

## Run it from the source

Download an [engine release](https://github.com/EthanCharpentier667/Aylo-Engine/releases), unzip it, and give the
program the `game/` folder of this repository:

```sh
aylo-engine-<version>-<os>-<arch>/runtime/aylo-runtime game
```

## What is in it

```
game/
  project.luau        the settings: Vulkan, GLFW, an 800x600 window, the plugins that draw
  scripts/main.luau   a camera and a circle, spawned at startup
  assets/             empty for now
```

The circle is an entity with `aylo.Transform` and `aylo.ShapeRenderer`; the camera looks at the middle of the view.
Change `radius` or `fillColor` in `scripts/main.luau` and run it again.

## Build

`scripts/build.sh <platform>` (`linux-x86_64`, `macos-arm64` or `windows-x86_64`) downloads the engine release named in
`engine-version.txt`, runs the game's scripts with its runtime, exports the game with `aylo-export` and writes the zip to
`dist/`. It needs `gh`, `cmake` and `bash`.

| Workflow | When | What |
|---|---|---|
| [CI](.github/workflows/ci.yml) | pull request, or a push to another branch | builds and exports the game on Linux, macOS and Windows |
| [Build](.github/workflows/build.yml) | push to `main` | the same, then replaces the `latest` prerelease with the three zips; a `v*` tag makes a draft release instead |

To follow a new engine version, change `engine-version.txt` to its release tag (`nightly` follows the engine's `main`).

## License

[MIT](LICENSE)
