# SteaSummonForever

**One button. One shared list. Your whole raid summoned.**

SteaSummonForever brings the beloved SteaSummon warlock summoning addon to **World of Warcraft: Forever** — rebuilt for the modern client, with full support for Forever's first/last character names, and extended with new quality-of-life features for the summoning warlock.

Raid night starts with forty people scattered across the world and three warlocks in trade chat arguing about who's next. This addon ends that: your raiders queue themselves, every warlock sees the same prioritized list, and summoning becomes clicking **one button** until the list is empty.

---

## Key Features

### ⭐ One-button summoning
Click **the** button and the addon targets the next person on the list and begins Ritual of Summoning — announcement whispers and raid messages included. Keep clicking, keep summoning. Out of mana? The button becomes a Life Tap button until you're ready again. Prefer keybinds? Bind "Summon Next" and never take your eyes off the movie.

### 📜 A shared summon list, synced across the raid
Every warlock (and raider) running the addon shares the *same* list, in the *same* order, with live status for everyone on it: requested, summon pending, summon accepted, dead, offline. Log in halfway through summons? You get the raid's current list, intact. Strong, durable network code keeps everyone honest.

### 💬 Raider self-service
Raiders type a trigger phrase — `123`, `summon plz`, or anything you configure — in raid, party, or whisper, and they're on the list. Typing `-123` (or clicking the ✕) takes them off. No addon required for raiders; it just works from chat.

### 🏔️ Smart priorities
Warlocks first (they make more portals), world-buffed players protected, named VIPs boosted — the priority rules are yours to configure, and the list sorts itself.

### 🚪 Automatic arrival cleanup
When someone accepts their summon — or walks in on foot — they drop off everyone's list automatically. No stale names, no manual pruning.

### 📣 Trade chat advertising *(new in Forever)*
A one-click **Ad** button sends your configurable advertisement to Trade chat, with a built-in cooldown (default 5 minutes) that physically prevents you from spamming — the button itself counts down until you're allowed to advertise again. Be the summon service, not the spam bot.

### 💤 AFK mode *(new in Forever)*
Stepping away mid-queue? One click sets you AFK: auto-invites pause, and anyone whispering for an invite or summon gets a polite automatic reply (once each — it won't flood them). Click again and you're back in business.

### 🤝 Auto invite & auto accept
Raiders whisper `inv` and they're in the group — gated by your choice of guild-only, guild + friends, anyone, or off. Invites to you can auto-accept with the same controls.

### 👥 Alt support
Long list, ticking world buffs? The addon whispers raiders far down the queue so they can log an alt, then whispers the alt when their main is nearly up. Buffs preserved, queue position kept.

### 👑 Raid management for the early warlock
Often the first one at the stone? Let the addon manage the raid until the real leader arrives: auto-convert to raid, hand out assists, set master loot, and relinquish lead to the configured raid leader when summons are done.

### 🔮 Soul shard counter
A live shard count on the summon window — including shards in a soul bag in your reagent bag slot — so you always know how many summons you have left.

---

## Built for WoW: Forever

This is not a re-zipped classic addon. The entire codebase was ported to the Forever client: modern API surface, first/last name support throughout, graceful handling of the client's secret values, and modern secure-button casting. It shows up as up-to-date because it *is* up to date.

## Lineage & Credits

SteaSummonForever continues a proud chain of fan maintenance: the original **SteaSummon** by prowley, the Wrath update by TheGeneticsGuy, and the Season of Discovery fork — now carried forward to Forever. Brought to you by **Summ Bert**.

## Bug Reports & Contributions

Issues, feature requests, and pull requests are welcome on [GitHub](https://github.com/edualve/SteaSummonForever). Found a bug? Type `!SS debug on` in /say, reproduce it, `/reload`, and attach your `SteaSummonForever.lua` SavedVariables file to the issue — the addon captures error details for you.

*Translations welcome — see the Locale folder on GitHub.*
