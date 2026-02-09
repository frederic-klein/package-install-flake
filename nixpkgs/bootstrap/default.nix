{ stdenv, bash }:

stdenv.mkDerivation {
  pname = "system-bootstrap";
  version = "0.0.1";

  src = ./.;

  buildInputs = [ bash ];

  installPhase = ''
    mkdir -p "$out/bin"
    cp -r bin/* "$out/bin/"

    mkdir -p "$out/share"
    cp -r share/* "$out/share"

    mkdir -p "$out/share/bash-completion/completions"
    bash bin/system-bootstrap completion > "$out/share/bash-completion/completions/system-bootstrap.bash"
  '';

  meta = {
    description = "bootstraps an Ubuntu system";
    platforms = [ "x86_64-linux" "aarch64-linux" ];
  };
}
