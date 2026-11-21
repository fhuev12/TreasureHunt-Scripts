# TreasureHunt-Scripts

Treasure Hunt Simulator auto-farm script, protected build.

## Usage

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/fhuev12/TreasureHunt-Scripts/main/TreasureHunt_Plus_v1.lua"))()
```

Requirements: an executor that provides `game:HttpGet`, `loadstring`, `bit32`, plus the `syn.queue_on_teleport` API used by the original script (`syn`, `krnl`, `fluxus` and most modern executors all ship it).

## Build

- source: `寻宝模拟器plus.lua` (29,333 bytes, 878 lines, SHA-256 `b135a61f31bf10c1b5885b1cbc3645a54bbe1ed66889aa07c5fd85e7d8aca756`)
- pipeline: LZSS compress -> 4-byte length header -> XOR (28-char key) -> Base64 -> 3 shards
- compressed: 7,931 bytes (27.0%), base64 payload 10,580 chars, loader 3,387 bytes
- verified: shards pulled from raw.githubusercontent.com decode back to 29,333 bytes with an identical SHA-256

## Layout

```
TreasureHunt_Plus_v1.lua   loader
parts/TreasureHunt_Plus_v1.p1.txt ... p3.txt
```

The loader fetches all shards, strips whitespace, base64-decodes, XOR-decrypts, LZSS-decompresses, verifies the declared length, then runs the payload. Any missing or tampered shard, or a wrong key, aborts before execution.

## What the script does

Kicks itself if the place id is not Treasure Hunt Simulator (1345139196) or if the GUI was already injected once (`getgenv().thunt_gui_executed`). Then provides a toggle GUI built on Kavo UI with: auto chest, auto sell, auto buy shovels / backpacks / pets / crates, auto rebirth, plus server-hop that scans `games.roblox.com` public server lists.

Remote calls used: `tool.RemoteClick` (digging), `check_if_owned` (InvokeServer), `buy_item`, `buy_crate`, `open_crate`, `rebirth`.

### Known external dependencies and the one leak to know about

- Line 570 loads the Kavo UI Library from `raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua`. The GUI will not appear if that mirror is down or renamed.
- Line 872 runs `syn.queue_on_teleport(game:HttpGet("https://raw.githubusercontent.com/glof2/thuntgui/main/GUI.lua"))`. After a server hop, the executor re-fetches the **upstream plaintext** script, so the protection on this repo only covers the first session. Repoint that URL at this loader if you want protection to survive teleport hops.

## Warning

This script acts client-side against a live Roblox game. It violates the Roblox Terms of Service and can get the account banned. Use only for your own private testing.
