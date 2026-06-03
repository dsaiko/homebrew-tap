class EdookitMcpRs < Formula
  desc "Unofficial MCP connector for Edookit (Czech school information system) — Rust port"
  homepage "https://github.com/dsaiko/edookit-mcp-rs"
  version "0.2.0"
  license "MIT"

  on_arm do
    url "https://github.com/dsaiko/edookit-mcp-rs/releases/download/v0.2.0/edookit-mcp_0.2.0_Darwin_arm64.tar.gz"
    sha256 "75819f7b91c8a870079f9b6faebc2648e9c0dd7cfebc6d8e9647a2de9465f236"
  end
  on_intel do
    url "https://github.com/dsaiko/edookit-mcp-rs/releases/download/v0.2.0/edookit-mcp_0.2.0_Darwin_x86_64.tar.gz"
    sha256 "5e9c16144b3d8a74f9ba265c4a25dc932e31aca1b41e5e2c3cfedf2f07785eb0"
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
