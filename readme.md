# hapësirë

**hapësirë** is a collection of famous sayings with a simple webpage and a [JSON:API](https://jsonapi.org/) compliant quote fetching API. Written in Elixir & [Slime](https://slime-lang.com) using [Ash](https://www.ash-hq.org).

It's available at https://hapesire.kira.computer/.


## Info

This project comes batteries included with ready to use sqlite database (as a mix dependency) that I compiled. I hope you can find something useful for yourself. Overall, it's a nice project to look into Ash Framework usage for APIs. You can also find a rather unhinged way of managing Slime templates in `lib/hapesire_web/templates.ex`.

API docs can be found here - https://hapesire.kira.computer/docs.

Repository with the database file and corresponding CSVs can be found on Codeberg - https://codeberg.org/q60/hapesire-db.

Here's some basic CLI client that supports this API - **[gigagei](https://github.com/q60/gigagei)**. Give it a try.

<img alt="screenshot of the webpage" src="hapesire.png" width="50%">


### Current stack

- Elixir `1.18.3`
- `ash ~> 3.0`
  - `ash_sqlite ~> 0.2`
  - `ash_json_api ~> 1.0`
- `plug_cowboy ~> 2.0`
- `slime`
- `gettext`


### Assets used

- [IBM Plex® typeface](https://github.com/IBM/plex) - SIL Open Font License, Version 1.1. Used remotely in `priv/static/styles/main.css`
  - IBM Plex Mono
  - IBM Plex Sans
  - IBM Plex Serif
- Elixir [logo](https://elixir-lang.org/trademarks). Used in `./priv/static/root.slime`
- [Ash Framework](https://ash-hq.org/) logo. Used in `./priv/static/root.slime`
- Creative Commons public domain [icon](https://creativecommons.org/mission/downloads/). Used in `./priv/static/root.slime`
- Creative Commons CC0 1.0 Universal license [icon](https://creativecommons.org/mission/downloads/). Used in `./priv/static/root.slime`


### Licensing

**hapësirë** is licensed under CC0 OR The Unlicense.


## Installation

Everything is straightforward:

```sh
MIX_ENV=prod mix deps.get
MIX_ENV=prod mix release

# path to release: _build/prod/rel/hapesire/bin/hapesire
```


## Contributing

Contributions are welcome. Before opening a PR, please make sure to run `mix format`, `mix credo --strict` and resolve any new issues.
