{pkgs ? (import ../nixpkgs.nix) {}}: {
  geist = pkgs.callPackage ./fonts/geist.nix {};
  geist-mono = pkgs.callPackage ./fonts/geist-mono.nix {};
  geist-mono-nerd = pkgs.callPackage ./fonts/geist-mono-nerd.nix {};
  geist-nf = pkgs.callPackage ./fonts/geist-nf.nix {};
}
