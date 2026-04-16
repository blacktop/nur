{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.14/ida-mcp_9.3.14_Linux_x86_64.tar.gz";
      hash = "sha256-tS4nETMr+m3/RWMnynzdvIUuu5eEoW5AuTfOoJ1Xhco=";
    };
    aarch64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.14/ida-mcp_9.3.14_Linux_arm64.tar.gz";
      hash = "sha256-wP8ryTouqFWxqc1VFUAjxIhXJvgw62R17lS2H4ut6ss=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.14/ida-mcp_9.3.14_Darwin_x86_64.tar.gz";
      hash = "sha256-H1vWjkPr2LHokQoyfjdgofGxWOddcnlovQBHIXrZ4Hw=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.14/ida-mcp_9.3.14_Darwin_arm64.tar.gz";
      hash = "sha256-RfKI/rxq1q2vVKCQclyvYZZsY1sXAldVMZSC9fo7Pqc=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.3.14";
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
