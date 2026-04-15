{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.13/ida-mcp_9.3.13_Linux_x86_64.tar.gz";
      hash = "sha256-FuDFrRUewuOt9nkE4nqE36SHxPQxVs59y6LkGKXd70E=";
    };
    aarch64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.13/ida-mcp_9.3.13_Linux_arm64.tar.gz";
      hash = "sha256-RuVUXzSdEdfWiAwIcJo3PCd1NwwVVGRXSZSHrHnM1TA=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.13/ida-mcp_9.3.13_Darwin_x86_64.tar.gz";
      hash = "sha256-QRvOYgXsIAoeZjaUl18/tHSBk0aZCsdUEaFxZJDKuV0=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.13/ida-mcp_9.3.13_Darwin_arm64.tar.gz";
      hash = "sha256-dTSWxyKbcieu9ku/zc4phBgFgONNFH903Cb1ZU2uU0M=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.3.13";
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
