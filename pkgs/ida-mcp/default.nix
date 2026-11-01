{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.5.0/ida-mcp_9.5.0_Linux_x86_64.tar.gz";
      hash = "sha256-YVTWLbIIx8wUjF9s+3sOovZn5cvpDLcKcufA/k/M8DU=";
    };
    aarch64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.5.0/ida-mcp_9.5.0_Linux_arm64.tar.gz";
      hash = "sha256-Msbr92bLWG+9kI/KEcanX9D1IFIi78Mb0JvvPTMM/RM=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.5.0/ida-mcp_9.5.0_Darwin_x86_64.tar.gz";
      hash = "sha256-jnpxPrmz4Nx8ThFmTc9H6CxRe5y7lgK/SGPCdrspGXI=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.5.0/ida-mcp_9.5.0_Darwin_arm64.tar.gz";
      hash = "sha256-TfogSLgmV1lTRFYSdp0v5Ul2cpwt+2XaClVufzz4KJQ=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.5.0";
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
