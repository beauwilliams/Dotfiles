# Remap macbook air alt to ctrl!!

hidutil property --set '{"UserKeyMapping":
    [{"HIDKeyboardModifierMappingSrc":0x7000000e6,
      "HIDKeyboardModifierMappingDst":0x7000000e4}]
}'

source: https://apple.stackexchange.com/questions/283252/how-do-i-remap-a-key-in-macos-sierra-e-g-right-alt-to-right-control

# Remove tunes from popping up when press play pause button

    NOTE FOR FUTURE OSX UPDATES:

From El Capitan onwards, you can either disable SIP or resort to a kind of hack, which will make iTunes inaccessible to any user, effectively preventing it from starting itself or its helpers. Be aware that for all intents and purposes this will trash your iTunes installation and may conflict with OS updates down the road.

sudo chmod 0000 /Applications/iTunes.app

