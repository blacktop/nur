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
    x86_64-linux = "1yq2ip6mfqdqs53yz5nf0kj8v21yvrsd272zc3hdpgy11iplmi60";
    aarch64-linux = "0d3kkw3p6nvqwgx5wl1gjgj9aga207wxl3mam6gdsh4mpjsdk0v7";
    x86_64-darwin = "0gz54c2bhw808j6rkmrwd5jb63m0shnp0zqazm69gyb7lbs3mhlg";
    aarch64-darwin = "049l3l2msmaw68662ggf8nf5kjlmx5r72i5f8hnyj52p27brbm4g";
  };

  urlMap = {
    x86_64-linux = "https://github.com/blacktop/ipsw/releases/download/v3.1.515/ipsw_3.1.515_linux_x86_64.tar.gz";
    aarch64-linux = "https://github.com/blacktop/ipsw/releases/download/v3.1.515/ipsw_3.1.515_linux_arm64.tar.gz";
    x86_64-darwin = "https://github.com/blacktop/ipsw/releases/download/v3.1.515/ipsw_3.1.515_macOS_x86_64.tar.gz";
    aarch64-darwin = "https://github.com/blacktop/ipsw/releases/download/v3.1.515/ipsw_3.1.515_macOS_arm64.tar.gz";
  };
in
stdenvNoCC.mkDerivation {
  pname = "ipsw";
  version = "3.1.515";
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
