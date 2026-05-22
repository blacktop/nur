{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.23/ida-mcp_9.3.23_Linux_x86_64.tar.gz";
      hash = "sha256-tm5DqW2TfNR6t0VFrhAYSd4TySN4by8PPO2mCZwWa8M=";
    };
    aarch64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.23/ida-mcp_9.3.23_Linux_arm64.tar.gz";
      hash = "sha256-jXpwu0RolV8tRmiyAupaT+xPVOymia5vtwxvXPfecH0=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.23/ida-mcp_9.3.23_Darwin_x86_64.tar.gz";
      hash = "sha256-cQs5/8bnhiw1/OZxNdgfmqCKQ74Oo9zWeBsinLHvmig=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.23/ida-mcp_9.3.23_Darwin_arm64.tar.gz";
      hash = "sha256-P+5Ik5ldgwInQjrY4kJReO2mavSoxLnzZKxySLjrv5U=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.3.23";
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
