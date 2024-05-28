{
	inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
	outputs = { self, nixpkgs }: {
		defaultPackage = {
			aarch64-darwin = buildPackage "aarch64-darwin";
			x86_64-linux = buildPackage "x86_64-linux";
		}
		buildPackage = system: 
			let 
			pkgs = import nixpkgs {
				inherit system;
			};
			in 
			pkgs.stdenv.mkDerivation {
				name = "hello";
				src = ./.;
				buildInputs = [ pkgs.go ];
				buildPhase = ''
					export GOCACHE=$(mktemp -d)
					cd hello
					go build -o hello
					'';
				installPhase = ''
					mkdir -p $out/bin
					install -t $out/bin hello
					'';
			};
	}
