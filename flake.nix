{
  description = "hapësirë";

  outputs = {self}: {
    nixosModules.default = {
      config,
      lib,
      pkgs,
      ...
    }: let
      beam-packages = pkgs.beamMinimal27Packages;

      src = ./.;
      version = "0.2.0";

      hapesire-deps = beam-packages.fetchMixDeps {
        pname = "mix-deps-hapesire";
        inherit src version;
        hash = "sha256-jTpEENjgluvODEl2VVnJd3+mY1zBhyosYQLns4W8FGY=";
      };

      hapesire = beam-packages.mixRelease {
        pname = "hapesire";
        version = "0.2.0";

        ELIXIR_MAKE_CACHE_DIR = "cache";
        src = ./.;

        mixFodDeps = hapesire-deps;
      };

      cfg = config.services.hapesire;
    in {
      options.services.hapesire = {
        enable = lib.mkEnableOption "hapësirë service";

        port = lib.mkOption {
          type = lib.types.port;
          default = 4000;
          description = "port hapësirë runs on";
        };
      };

      config = lib.mkIf cfg.enable {
        nixpkgs.overlays = [(final: prev: {hapesire = hapesire;})];

        systemd.services.hapesire = {
          wantedBy = ["multi-user.target"];

          after = ["network.target"];

          environment = {
            HAPESIRE_PORT = toString cfg.port;
            HAPESIRE_DB = "${hapesire-deps}/hapesire_db/collection.db";
            RELEASE_COOKIE = "a";
          };

          serviceConfig.ExecStart = "${pkgs.hapesire}/bin/hapesire start";
        };
      };
    };
  };
}
