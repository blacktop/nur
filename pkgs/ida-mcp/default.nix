{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.9/ida-mcp_9.3.9_Linux_x86_64.tar.gz";
      hash = "sha256-Y9vOEdPil6zeU1IAImVrBNaQChoyrbHsiHqI/00iobY=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.9/ida-mcp_9.3.9_Darwin_x86_64.tar.gz";
      hash = "sha256-zuvh0dA+5f/gN0HLCdeHP9cWHW3zNSLLbP6wR3F5UPU=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.9/ida-mcp_9.3.9_Darwin_arm64.tar.gz";
      hash = "sha256-Yqm+J3iHy8ETdV5m6K2r5k+sUI+TdLCiSECtOl4rIdU=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.3.9";
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
