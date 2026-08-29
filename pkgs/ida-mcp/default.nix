{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.4.3/ida-mcp_9.4.3_Linux_x86_64.tar.gz";
      hash = "sha256-2Mzj8nyukpD8KJOj7RNDCg/x7f3jJQ17TPO5TiqI8wY=";
    };
    aarch64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.4.3/ida-mcp_9.4.3_Linux_arm64.tar.gz";
      hash = "sha256-hx765QSbo20uSQo59jXwLUtTYDN5+aDpHSk/hBvfT0w=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.4.3/ida-mcp_9.4.3_Darwin_x86_64.tar.gz";
      hash = "sha256-oTNzwCNMqHFSzNHOYGd9NdXZrL1CwZsvxK+FpYW08tg=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.4.3/ida-mcp_9.4.3_Darwin_arm64.tar.gz";
      hash = "sha256-YK7Pgsq11EAt/ZoFS6qt1Tzkye4lZV0KAJ8nQYBnjGg=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.4.3";
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
