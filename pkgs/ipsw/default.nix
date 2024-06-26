# This file was generated by GoReleaser. DO NOT EDIT.
# vim: set ft=nix ts=2 sw=2 sts=2 et sta
{
system ? builtins.currentSystem
, lib
, fetchurl
, installShellFiles
, stdenvNoCC
}:
let
  shaMap = {
    x86_64-linux = "01109x8mmjvixx6k0ymnakwkxx4mn2n7w3sfmhl2nb2k3vmikqx0";
    aarch64-linux = "05wvl7va6fdm85asm612xa0wpp90rzxfqj19xk6w33qkpm5v6ak5";
    x86_64-darwin = "1lad1f6nbbyzkvr5b2ix7d6hsld3xqb4mhfqq4sglhg8rnzhi78y";
    aarch64-darwin = "02dxm8plzv5in46619wq7hyj1w40dz6jb0mj3yhpinfzvlk4kr20";
  };

  urlMap = {
    x86_64-linux = "https://github.com/blacktop/ipsw/releases/download/v3.1.507/ipsw_3.1.507_linux_x86_64.tar.gz";
    aarch64-linux = "https://github.com/blacktop/ipsw/releases/download/v3.1.507/ipsw_3.1.507_linux_arm64.tar.gz";
    x86_64-darwin = "https://github.com/blacktop/ipsw/releases/download/v3.1.507/ipsw_3.1.507_macOS_x86_64.tar.gz";
    aarch64-darwin = "https://github.com/blacktop/ipsw/releases/download/v3.1.507/ipsw_3.1.507_macOS_arm64.tar.gz";
  };
in
stdenvNoCC.mkDerivation {
  pname = "ipsw";
  version = "3.1.507";
  src = fetchurl {
    url = urlMap.${system};
    sha256 = shaMap.${system};
  };

  sourceRoot = ".";

  nativeBuildInputs = [ installShellFiles ];

  installPhase = ''
    mkdir -p $out/bin
    cp -vr ./ipsw $out/bin/ipsw
    installManPage ./manpages/ipsw.1.gz
    installShellCompletion ./completions/ipsw/*
  '';

  system = system;

  meta = {
    description = "iOS/macOS Research Swiss Army Knife";
    homepage = "https://github.com/blacktop/ipsw";
    license = lib.licenses.mit;

    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];

    platforms = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];
  };
}
