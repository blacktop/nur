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
    x86_64-linux = "1hx1xmfxfhgpn9dk0dys7zxmh3fgrczjh6q74ffcf9gz7lslsra7";
    aarch64-linux = "03ys3i9qn9iqwdsq77cjh71vj7fqxhcfd1lax4anwqa2nbmnggsi";
    x86_64-darwin = "16xq43b0637rcyw8ki8swwr6qdczr26ncbj627xbd3jribkvbjx1";
    aarch64-darwin = "1cfqjw7s7dn8lizxgbfjxh3g8cs38rc4c3pn7w1ix9vpgj09fhd5";
  };

  urlMap = {
    x86_64-linux = "https://github.com/blacktop/ipsw/releases/download/v3.1.572/ipsw_3.1.572_linux_x86_64.tar.gz";
    aarch64-linux = "https://github.com/blacktop/ipsw/releases/download/v3.1.572/ipsw_3.1.572_linux_arm64.tar.gz";
    x86_64-darwin = "https://github.com/blacktop/ipsw/releases/download/v3.1.572/ipsw_3.1.572_macOS_x86_64.tar.gz";
    aarch64-darwin = "https://github.com/blacktop/ipsw/releases/download/v3.1.572/ipsw_3.1.572_macOS_arm64.tar.gz";
  };
in
stdenvNoCC.mkDerivation {
  pname = "ipsw";
  version = "3.1.572";
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
