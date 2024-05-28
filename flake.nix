{
	inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
	outputs = { self, nixpkgs }: {
		defaultPackage.aarch64-darwin = 
			with import nixpkgs {
				system = "aarch64-darwin"; 
			};
			stdenv.mkDerivation {
				name = "hello";
				src = self;
				buildInputs = [ go ];
				buildPhase = ''
					export GOCACHE=$(mktemp -d)
					go build -o hello main.go
				'';
				installPhase = "mkdir -p $out/bin; install -t $out/bin hello";
			};

	};
}
