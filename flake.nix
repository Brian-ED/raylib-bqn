{
  description = "raylib-bqn is a raylib binding for the BQN programming language";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}:
  let
    supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" ];
    forAllSystems = f: builtins.listToAttrs (map (system: {
      name = system;
      value = f system;
    }) supportedSystems);
  in {
    packages = forAllSystems (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      raylibLib = pkgs.raylib + "/lib/" + (
        if pkgs.stdenv.isDarwin
        then "libraylib.dylib"
        else "libraylib.so"
      );
      raylib-bqn = pkgs.stdenv.mkDerivation {
        pname = "raylib-bqn";
        version = "rolling";
        meta = {
          description = "raylib-bqn is a binding to raylib, meaning all values and functions defined in raylib are exposed to BQN";
          license = pkgs.lib.licenses.mit;
        };
        buildInputs = [ pkgs.raylib ];
        src = ./.;
        installPhase = ''
          mkdir -p "$out"
          cp raylib.bqn "$out"
        '';
        postPatch = ''
          substituteInPlace raylib.bqn \
            --replace-fail '#INSERT-CUSTOM-RAYLIB-PATH-''+/*NOT*/''HERE' '"${raylibLib}"'
        '';
      };
    in {
      inherit raylib-bqn;
      default = raylib-bqn;
    });
  };
}
