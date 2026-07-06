{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.25/ida-mcp_9.3.25_Linux_x86_64.tar.gz";
      hash = "sha256-7A2dml9xVKSHU9EHNJWhe5utP5c6Nn1QSejK0V+Ovhg=";
    };
    aarch64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.25/ida-mcp_9.3.25_Linux_arm64.tar.gz";
      hash = "sha256-TboOEKq2aWudqqzeQ8fiXbeepVkN4n4Rnqzi5mDTWJ8=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.25/ida-mcp_9.3.25_Darwin_x86_64.tar.gz";
      hash = "sha256-tq6PKkh0wXWsfyjMbZ3PC78Wn9NMXxyNKb6mmVlqXAU=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.25/ida-mcp_9.3.25_Darwin_arm64.tar.gz";
      hash = "sha256-BbDLFXA/uWJFqS1T5ZClIfyVWzMsE8Ow03hC5IJWOOw=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.3.25";
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
