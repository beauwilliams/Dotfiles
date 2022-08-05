#!/usr/bin/env python3

import asyncio
import iterm2

# Place me here -> /Users/admin/Library/Application Support/iTerm2/Scripts/
# Click on Scripts drowndown in iTerm to start the script
async def main(connection):
    async with iterm2.VariableMonitor(connection, iterm2.VariableScopes.APP, "effectiveTheme", None) as mon:
        while True:
            # Block until theme changes
            theme = await mon.async_get()

            # Themes have space-delimited attributes, one of which will be light or dark.
            parts = theme.split(" ")
            if "dark" in parts:
                preset = await iterm2.ColorPreset.async_get(connection, "my-custom-gruvbox-soft")
            else:
                preset = await iterm2.ColorPreset.async_get(connection, "github_light")

            # Update the list of all profiles and iterate over them.
            profiles=await iterm2.PartialProfile.async_query(connection)
            for partial in profiles:
                # Fetch the full profile and then set the color preset in it.
                profile = await partial.async_get_full_profile()
                await profile.async_set_color_preset(preset)

iterm2.run_forever(main)
