{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.15/ida-mcp_9.3.15_Linux_x86_64.tar.gz";
      hash = "sha256-0tzDVEMI1ru1NpjsNEk+45K84v823MndvAzllfHlwmk=";
    };
    aarch64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.15/ida-mcp_9.3.15_Linux_arm64.tar.gz";
      hash = "sha256-L3KlU3b6yrslwCAYbzUEQRZ0VH8DNWgeBnA7jEAoiuw=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.15/ida-mcp_9.3.15_Darwin_x86_64.tar.gz";
      hash = "sha256-MJJCLPy8TIC/uCkAM81sLBAekXl+QbJGe9X8UYiIiNc=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.15/ida-mcp_9.3.15_Darwin_arm64.tar.gz";
      hash = "sha256-yioRLS7J1jDLDaTa+Vjybt366ooRDFXSZAfO2nT6Ruw=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.3.15";
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
