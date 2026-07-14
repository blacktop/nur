{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.4.0/ida-mcp_9.4.0_Linux_x86_64.tar.gz";
      hash = "sha256-JN48e9wsib2jDmTwRi2oBXlx0wdSfMyAqhZ6dHdEQ6E=";
    };
    aarch64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.4.0/ida-mcp_9.4.0_Linux_arm64.tar.gz";
      hash = "sha256-6N0AN8Z54rnp74oR1le42nZqbXxDH2UXwleNajywZN8=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.4.0/ida-mcp_9.4.0_Darwin_x86_64.tar.gz";
      hash = "sha256-l08rpYh8qKmCodP6Eo9lTi4XwzWH43242Df7d1Qmy6o=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.4.0/ida-mcp_9.4.0_Darwin_arm64.tar.gz";
      hash = "sha256-5FkuuBqqdawqV+5vgEz5dwI7FDP9NdxJhJCjMcyQiQQ=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.4.0";
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
