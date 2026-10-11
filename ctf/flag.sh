#!/bin/sh
# Places the player's flag (CTF_FLAG_MAIN, given by the launcher) (client-side lab: a victim bot is to deliver it later);
# without one (CI, a run by hand) the development flag.
dev='FLAG{dev-skf-cors}'
printf '%s\n' "${CTF_FLAG_MAIN:-$dev}" > /ctf/flag
chmod 444 /ctf/flag
