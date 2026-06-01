class EdookitMcpRs < Formula
  desc "Unofficial MCP connector for Edookit (Czech school information system) — Rust port"
  homepage "https://github.com/dsaiko/edookit-mcp-rs"
  version "0.1.1"
  license "MIT"

  on_arm do
    url "https://github.com/dsaiko/edookit-mcp-rs/releases/download/v0.1.1/edookit-mcp_0.1.1_Darwin_arm64.tar.gz"
    sha256 "0b2e2afa0866654587f587e313b73c999acb56d388e37d7b4141bbf929425ee3"
  end
  on_intel do
    url "https://github.com/dsaiko/edookit-mcp-rs/releases/download/v0.1.1/edookit-mcp_0.1.1_Darwin_x86_64.tar.gz"
    sha256 "f9e7b66ab61e6ec4504d3a238e22af5619abf0cc6315ad50836185305aa40fec"
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
