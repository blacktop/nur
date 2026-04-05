{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.4/ida-mcp_9.3.4_Linux_x86_64.tar.gz";
      hash = "sha256-A8JJWAg+2mHd6eGPUVxbDjw1UHB0OsjCBMUBYB1zvXQ=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.4/ida-mcp_9.3.4_Darwin_x86_64.tar.gz";
      hash = "sha256-GGk0Ruh9qi4fpKO9hOGYJcP6UvKjSrMUHr4a6PT1Tbw=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.4/ida-mcp_9.3.4_Darwin_arm64.tar.gz";
      hash = "sha256-btAZade05yTA6ue35Up+zo2TuvZxJHu8I7T3gZOzt10=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.3.4";
  src = fetchurl {
    url = platform.url;
    sha256 = platform.hash;
  };
  sourceRoot = ".";
  installPhase = ''
    mkdir -p $out/bin
    cp -v ./ida-mcp $out/bin/ida-mcp
  '';
  meta = {
    description = "Headless IDA Pro MCP Server for AI-powered binary analysis";
    homepage = "https://github.com/blacktop/ida-mcp-rs";
    license = lib.licenses.mit;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = lib.attrNames supported;
  };
}
