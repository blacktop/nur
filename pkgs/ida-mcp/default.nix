{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.22/ida-mcp_9.3.22_Linux_x86_64.tar.gz";
      hash = "sha256-uhQtbCUfHOlGH3hdEHBCqmvFZKpDXdOThgqWalwKIy0=";
    };
    aarch64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.22/ida-mcp_9.3.22_Linux_arm64.tar.gz";
      hash = "sha256-eJaAFH3X1yvA5cTHPeTdq1OyF80bVXQK0LzHBMheiFI=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.22/ida-mcp_9.3.22_Darwin_x86_64.tar.gz";
      hash = "sha256-VyhdIGvcOUeYDY1BoqQCLhA2zNDm9C/efehz2BNTU60=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.22/ida-mcp_9.3.22_Darwin_arm64.tar.gz";
      hash = "sha256-FSljdbGKQhNON/mQcplckH+lqP3+EsZIOl8sL668Vds=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.3.22";
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
