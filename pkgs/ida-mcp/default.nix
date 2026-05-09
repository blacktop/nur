{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.17/ida-mcp_9.3.17_Linux_x86_64.tar.gz";
      hash = "sha256-32sj26GNSp1G8GU7Stpv5OdMM95+HqRNBXJvVhh0X1U=";
    };
    aarch64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.17/ida-mcp_9.3.17_Linux_arm64.tar.gz";
      hash = "sha256-bNVO0Vpir4HhDH9N/SpPBdIlqd7pklg0AwlmUFEzx8U=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.17/ida-mcp_9.3.17_Darwin_x86_64.tar.gz";
      hash = "sha256-RQfFseWq2VbVcYSO9Xnc9oGXJoNhqccJHW+ZEBvMzi0=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.17/ida-mcp_9.3.17_Darwin_arm64.tar.gz";
      hash = "sha256-esga7TVn+fmDoCnPpAVWnthXJrU0rhB/XcDDYbXUcv4=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.3.17";
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
