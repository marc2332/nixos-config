{
  pkgs,
}:

pkgs.rustPlatform.buildRustPackage (finalAttrs: {
  pname = "gitui";
  version = "0.27.0";

  src = pkgs.fetchFromGitHub {
    owner = "gitui-org";
    repo = "gitui";
    tag = "v${finalAttrs.version}";
    hash = "sha256-jKJ1XnF6S7clyFGN2o3bHnYpC4ckl/lNXscmf6GRLbI=";
  };

  cargoHash = "sha256-Le/dD8bTd5boz1IeEq4ItJZYC3MRW8uiT/3Zy1yv5L0=";

  nativeBuildInputs = [
    pkgs.cmake
    pkgs.pkg-config
    pkgs.openssl
    pkgs.perl
    pkgs.git
  ];

  doCheck = false;

  meta = {
    description = "Blazing 💥 fast terminal-ui for git written in rust 🦀 ";
    homepage = "https://github.com/gitui-org/gitui";
    license = pkgs.lib.licenses.unlicense;
    maintainers = [ ];
  };
})
