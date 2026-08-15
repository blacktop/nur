{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.4.2/ida-mcp_9.4.2_Linux_x86_64.tar.gz";
      hash = "sha256-K06JMeyHOApHSZC4Ieuq8ZBu+/XzzSzLwkIhbUv8wgU=";
    };
    aarch64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.4.2/ida-mcp_9.4.2_Linux_arm64.tar.gz";
      hash = "sha256-Cj417G9PGNIGtihK34ATv8mA/as9NqaQTaCoEiuFtSM=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.4.2/ida-mcp_9.4.2_Darwin_x86_64.tar.gz";
      hash = "sha256-WyGtRi1pXLCGLeZmqKtVo56BDHHW3sAD/XqSiQHFsQY=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.4.2/ida-mcp_9.4.2_Darwin_arm64.tar.gz";
      hash = "sha256-d29hNqyVdxomKZQKb7e3OUmdZaP8NLm2lGuCCQF0iN4=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.4.2";
  src = fetchurl {
    url = platform.url;
    sha256 = platform.hash;
  };
  sourceRoot = ".";
  installPhase = ''
    mkdir -p $out/bin
    cp -v ./ida-mcp $out/bin/ida-mcp
    if [ -f ./ida-mcp-bin ]; then
      cp -v ./ida-mcp-bin $out/bin/ida-mcp-bin
    fi
  '';
  meta = {
    description = "Headless IDA Pro MCP Server for AI-powered binary analysis";
    homepage = "https://github.com/blacktop/ida-mcp-rs";
    license = lib.licenses.mit;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = lib.attrNames supported;
  };
}
