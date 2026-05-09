{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.19/ida-mcp_9.3.19_Linux_x86_64.tar.gz";
      hash = "sha256-zVYLoikkVR8WpVhnMc7bTM8AO8Rw97D3PWgB9ibntM0=";
    };
    aarch64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.19/ida-mcp_9.3.19_Linux_arm64.tar.gz";
      hash = "sha256-7zchqbP5LsInJln/lgmMTrGBp+I4NcG98i15g1ItZSk=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.19/ida-mcp_9.3.19_Darwin_x86_64.tar.gz";
      hash = "sha256-d+JoErvQyGuNLsccmuUH8MyKI8AL4UneJOiI5ZZvTvE=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.19/ida-mcp_9.3.19_Darwin_arm64.tar.gz";
      hash = "sha256-EK1z0sGVV2Ow5FHTWzM/t4Z6IC5cx/BuAskdedDY/ow=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.3.19";
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
