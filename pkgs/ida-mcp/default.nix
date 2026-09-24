{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.4.4/ida-mcp_9.4.4_Linux_x86_64.tar.gz";
      hash = "sha256-za8/MyyLlNJ2T2FXfO/UGbBpPavfZK6XJD1voC3eY5g=";
    };
    aarch64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.4.4/ida-mcp_9.4.4_Linux_arm64.tar.gz";
      hash = "sha256-75aQs7dkhiCAfRBxVEvWqr0668sKQapNPvcqjhGoLwQ=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.4.4/ida-mcp_9.4.4_Darwin_x86_64.tar.gz";
      hash = "sha256-Ir5IxDRwypwtKgrQfw8ONIqWJaHfcs7UmEw6SSdRCGM=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.4.4/ida-mcp_9.4.4_Darwin_arm64.tar.gz";
      hash = "sha256-VQJsMbxmec8ZPeX/jsMFlgGpZQ3lX7G5XR2tx5nUBGo=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.4.4";
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
