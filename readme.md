# hapësirë

**hapësirë** is a collection of famous sayings with a simple webpage and a [JSON:API](https://jsonapi.org/) compliant quote fetching API. Written in Elixir & [Slime](https://slime-lang.com) using [Ash](https://www.ash-hq.org).

It's available to everyone at https://hapesire.kira.computer/.


## info

This project comes batteries included with ready to use sqlite database that I compiled. I hope you can find something useful for yourself. Overall, it's a nice project to look into Ash Framework usage for APIs. You can also find a rather unhinged way of managing Slime templates in `lib/hapesire_web/templates.ex`.

![screenshot of the webpage](https://gist.github.com/user-attachments/assets/e8543341-a637-4af1-8223-bfbe8a989d15)

**Current stack:**
- Elixir `1.18.3`
- `ash` `3.x`
  - `ash_sqlite`
  - `ash_json_api`
- `plug_cowboy` `2.x`
- `slime`
- `gettext`

**Assets used:**
- [IBM Plex® typeface](https://github.com/IBM/plex) - SIL Open Font License, Version 1.1. Used remotely in `priv/static/styles/main.css`
  - IBM Plex Mono
  - IBM Plex Sans
  - IBM Plex Serif
- [Elixir logo](https://elixir-lang.org/trademarks)
- [Ash Framework logo](https://ash-hq.org/)
- [Creative Commons public domain icon](https://creativecommons.org/mission/downloads/)
- [Creative Commons CC0 1.0 Universal license icon](https://creativecommons.org/mission/downloads/)
