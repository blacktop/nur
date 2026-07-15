{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.4.1/ida-mcp_9.4.1_Linux_x86_64.tar.gz";
      hash = "sha256-P3uLfRZk1+VxtQ7pYKCfo4wTGJmPQiL3m3m8ScZ3PmY=";
    };
    aarch64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.4.1/ida-mcp_9.4.1_Linux_arm64.tar.gz";
      hash = "sha256-qTXsq3ka1XSz27PRPP68hOg9zZpGLFfF+XugoJqstkA=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.4.1/ida-mcp_9.4.1_Darwin_x86_64.tar.gz";
      hash = "sha256-AarNOgM1Jf4khgBrED0vkQr9oM5jeKSTz8n/uSKV7jc=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.4.1/ida-mcp_9.4.1_Darwin_arm64.tar.gz";
      hash = "sha256-XTMW8SfFZdnGLWb3B9X8/I/jHq74mfy9Al9OpGh7tGo=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.4.1";
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
