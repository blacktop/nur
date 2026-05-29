{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.24/ida-mcp_9.3.24_Linux_x86_64.tar.gz";
      hash = "sha256-Ls9ZaPWTFA82waOtndF4lN/ZDC9P1PfEGJxMkhXqNiQ=";
    };
    aarch64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.24/ida-mcp_9.3.24_Linux_arm64.tar.gz";
      hash = "sha256-VaK1I8sChVntqkfphLpDopCvS13nt2ySgxjiQVsfiLw=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.24/ida-mcp_9.3.24_Darwin_x86_64.tar.gz";
      hash = "sha256-tfpReVcixZsG3X0+oOzgtuKGOKN/+6d0XrRiEg2w770=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.24/ida-mcp_9.3.24_Darwin_arm64.tar.gz";
      hash = "sha256-PNNkCkmE4XUCw9wN4DwtxQZY41ot8WYSBUIkJUCWzgQ=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.3.24";
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
