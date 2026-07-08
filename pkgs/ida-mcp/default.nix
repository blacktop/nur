{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.26/ida-mcp_9.3.26_Linux_x86_64.tar.gz";
      hash = "sha256-JjyQYJmvOYzq9YpHXXV0oX2g7zhTkNRjybPGw214JAA=";
    };
    aarch64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.26/ida-mcp_9.3.26_Linux_arm64.tar.gz";
      hash = "sha256-XuiUos1wPR6xcmVEEujL/Yvf0gHb1Mh7HuaGgepCLuE=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.26/ida-mcp_9.3.26_Darwin_x86_64.tar.gz";
      hash = "sha256-R/tqCSPsbaBqQrqN0Zv6bbRL2Jg30LVvjKOdP1862gY=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.26/ida-mcp_9.3.26_Darwin_arm64.tar.gz";
      hash = "sha256-ODeX/ZxW3LX512JeMqB3Gs1S8MyPWzuW0nhNq91nyKA=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.3.26";
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
