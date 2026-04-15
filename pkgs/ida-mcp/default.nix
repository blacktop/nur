{
  lib,
  fetchurl,
  stdenvNoCC,
}:
let
  inherit (stdenvNoCC.hostPlatform) system;
  supported = {
    x86_64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.12/ida-mcp_9.3.12_Linux_x86_64.tar.gz";
      hash = "sha256-JQChy7lWRxRPMkTsZ2U7EcE5NXBzHbHekFTCC6oaZTk=";
    };
    aarch64-linux = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.12/ida-mcp_9.3.12_Linux_arm64.tar.gz";
      hash = "sha256-qIe4ICXYv4Wt5tEBH6ee8PyhGm122hylxrvSVGkhnlc=";
    };
    x86_64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.12/ida-mcp_9.3.12_Darwin_x86_64.tar.gz";
      hash = "sha256-it5cgOWLE3/Fm4JfXS0WLbUPdYmmypM3HkjNfyrHiS4=";
    };
    aarch64-darwin = {
      url = "https://github.com/blacktop/ida-mcp-rs/releases/download/v9.3.12/ida-mcp_9.3.12_Darwin_arm64.tar.gz";
      hash = "sha256-Gg/qFn4tzVYJCzjo2WltJMVVl6ZICaBhL3gUDrUDMIo=";
    };
  };
  platform = supported.${system} or (throw "ida-mcp: unsupported system ${system}");
in
stdenvNoCC.mkDerivation {
  pname = "ida-mcp";
  version = "9.3.12";
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
