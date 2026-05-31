# Mac autocorrect wordlist

A wordlist you add to the macOS keyboard's Text Replacements so technical jargon
and acronyms (`kubectl`, `mtls`, `ebpf`, `proto`…) stop getting autocorrected.
Syncs to your iPhone/iPad via iCloud.

## Use

Drag `TextReplacements.plist` into **System Settings → Keyboard → Text
Replacements**. It syncs to iOS automatically.

## Edit

Add canonical-cased terms to `words.txt` (e.g. `OAuth`, `gRPC`) — typing the
lowercase letters (`oauth`, `grpc`) autocorrects to that form. Then run
`./generate.sh` to rebuild the plist.
