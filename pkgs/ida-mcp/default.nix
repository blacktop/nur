{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.3/ida-mcp_9.3.3_Linux_x86_64.tar.gz";
      hash = "sha256-cyg2D7gbw19UnGXNWTXDx8L1L58RbA6jv+qh6ANAH3A=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.3/ida-mcp_9.3.3_Darwin_x86_64.tar.gz";
      hash = "sha256-782cUnD1OGsiQlP4XIaQrzVIme/qYXC+TbOuSLa9Nkw=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.3/ida-mcp_9.3.3_Darwin_arm64.tar.gz";
      hash = "sha256-wr/JM0P+91rKx/M9gMw4DMrCISU7ZxqampkSMuFzyh0=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.3.3";
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
