{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.21/ida-mcp_9.3.21_Linux_x86_64.tar.gz";
      hash = "sha256-sSYziMAOKAjDDEVKducebLIp526tTn/kLZCJvkpp0oI=";
    };
    aarch64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.21/ida-mcp_9.3.21_Linux_arm64.tar.gz";
      hash = "sha256-I1yhOz5J+/Nb1Q4+MVabrlCHO/6vV8hNUdScaV+PUy4=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.21/ida-mcp_9.3.21_Darwin_x86_64.tar.gz";
      hash = "sha256-Rr0e+vC9qhKoOEyIZmrzvjvOz6Sr9pLoDphiflif/jI=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.21/ida-mcp_9.3.21_Darwin_arm64.tar.gz";
      hash = "sha256-d7iYvjCWzimseqRTRAmBFcNh9DDMbCDucGyxFttve2E=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.3.21";
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
