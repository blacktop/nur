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
    x86_64-linux = "1yqgz6nfzq9n4c8n9m4lawf3pb80in17ib98izrkymbxq70fg7nw";
    aarch64-linux = "1vp8lwp3jl4ai6wanxlhd2m2fdwmryz22p51zdf075x2il2ilfhl";
    x86_64-darwin = "00v894x53fqsbn3aywsmlgmlmfd0r7qs9q2iryd54rmyyxb36d1s";
    aarch64-darwin = "19r2sa791b791va48lsz3m7vgsg546i3hm3vib9vw7w6dp85kly6";
  };

  urlMap = {
    x86_64-linux = "https://github.com/blacktop/ipsw/releases/download/v3.1.583/ipsw_3.1.583_linux_x86_64.tar.gz";
    aarch64-linux = "https://github.com/blacktop/ipsw/releases/download/v3.1.583/ipsw_3.1.583_linux_arm64.tar.gz";
    x86_64-darwin = "https://github.com/blacktop/ipsw/releases/download/v3.1.583/ipsw_3.1.583_macOS_x86_64.tar.gz";
    aarch64-darwin = "https://github.com/blacktop/ipsw/releases/download/v3.1.583/ipsw_3.1.583_macOS_arm64.tar.gz";
  };
in
stdenvNoCC.mkDerivation {
  pname = "ipsw";
  version = "3.1.583";
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
