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
    x86_64-linux = "1n3vscbmgv3shawx048q8wv9fxf9s1lyyx5lmkmvlrp5ayd6nr68";
    aarch64-linux = "0a6rda712iclibvbar5xh8zllgchdwqwdgaif8bps9xlaffri4av";
    x86_64-darwin = "0wljlhfkn2cv4djkhgqgdbcpzk6105ni96jzq8s12x0l8gmld6ak";
    aarch64-darwin = "1dkvjvmv3bch76v3xjldmhfxypwrvh514q4qsrwnwpbpdnf9jvmd";
  };

  urlMap = {
    x86_64-linux = "https://github.com/blacktop/ipsw/releases/download/v3.1.456/ipsw_3.1.456_linux_x86_64.tar.gz";
    aarch64-linux = "https://github.com/blacktop/ipsw/releases/download/v3.1.456/ipsw_3.1.456_linux_arm64.tar.gz";
    x86_64-darwin = "https://github.com/blacktop/ipsw/releases/download/v3.1.456/ipsw_3.1.456_macOS_x86_64.tar.gz";
    aarch64-darwin = "https://github.com/blacktop/ipsw/releases/download/v3.1.456/ipsw_3.1.456_macOS_arm64.tar.gz";
  };
in
stdenvNoCC.mkDerivation {
  pname = "ipsw";
  version = "3.1.456";
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
