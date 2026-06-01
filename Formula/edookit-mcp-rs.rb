class EdookitMcpRs < Formula
  desc "Unofficial MCP connector for Edookit (Czech school information system) — Rust port"
  homepage "https://github.com/dsaiko/edookit-mcp-rs"
  version "0.1.2"
  license "MIT"

  on_arm do
    url "https://github.com/dsaiko/edookit-mcp-rs/releases/download/v0.1.2/edookit-mcp_0.1.2_Darwin_arm64.tar.gz"
    sha256 "1e8a448dc7a9dd604ffb3351c55e6c98d79a0fc404f88fef2ed69b2c0f177480"
  end
  on_intel do
    url "https://github.com/dsaiko/edookit-mcp-rs/releases/download/v0.1.2/edookit-mcp_0.1.2_Darwin_x86_64.tar.gz"
    sha256 "552b077ff2a67ea9608db90eec0ba53916d688d654928b9c4d197f0f81b1591b"
  end

  def install
    # Keep the binary and its bundled libpdfium together so the exe-dir
    # PDFium resolution works; symlink onto PATH as edookit-mcp-rs so it
    # can coexist with the Go build's edookit-mcp from the same tap.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"edookit-mcp" => "edookit-mcp-rs"
  end

  def caveats
    <<~EOS
      Installs as edookit-mcp-rs (the Go build installs as edookit-mcp).
      Drives a real Chromium/Chrome instance once per ~10h to log into Plus4U,
      so install a Chromium-family browser. Configure via
      EDOOKIT_URL / EDOOKIT_USER / EDOOKIT_PASS. PDF attachment rasterization
      uses the bundled libpdfium installed next to the binary.
    EOS
  end

  test do
    assert_match "required env var", shell_output("#{bin}/edookit-mcp-rs 2>&1", 1)
  end
end
