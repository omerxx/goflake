{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";

  outputs = { self, nixpkgs }: {
    defaultPackage = {
      aarch64-darwin = let
        pkgs = import nixpkgs { system = "aarch64-darwin"; };
      in pkgs.stdenv.mkDerivation {
        name = "hello";
        src = self;
        buildInputs = [ pkgs.go ];
        buildPhase = ''
          export GOCACHE=$(mktemp -d)
          go build -o hello main.go
        '';
        installPhase = ''
          mkdir -p $out/bin
          install -t $out/bin hello
        '';
      };

      x86_64-linux = let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in pkgs.stdenv.mkDerivation {
        name = "hello";
        src = self;
        buildInputs = [ pkgs.go ];
        buildPhase = ''
          export GOCACHE=$(mktemp -d)
          go build -o hello main.go
        '';
        installPhase = ''
          mkdir -p $out/bin
          install -t $out/bin hello
        '';
      };
    };
  };
}
