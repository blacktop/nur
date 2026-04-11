{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.11/ida-mcp_9.3.11_Linux_x86_64.tar.gz";
      hash = "sha256-/WqYQ0QCnt1Mm+h2hxix2A6PJPm0gcUyaE5pG75p9bQ=";
    };
    aarch64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.11/ida-mcp_9.3.11_Linux_arm64.tar.gz";
      hash = "sha256-VCaGTxOda4KZhcab+cfWpPrfcgcDD9BIrPxtFafdvuk=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.11/ida-mcp_9.3.11_Darwin_x86_64.tar.gz";
      hash = "sha256-YFULn2ZqfCR4tzL6sNU84gdMV+mBQ8StyEOGTV2Wq0c=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.11/ida-mcp_9.3.11_Darwin_arm64.tar.gz";
      hash = "sha256-q09GCM9eLNCI27idapPhIhCOjecpTbhuQm9HKj16tG0=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.3.11";
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
