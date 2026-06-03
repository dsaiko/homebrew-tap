class EdookitMcpRs < Formula
  desc "Unofficial MCP connector for Edookit (Czech school information system) — Rust port"
  homepage "https://github.com/dsaiko/edookit-mcp-rs"
  version "0.2.2"
  license "MIT"

  on_arm do
    url "https://github.com/dsaiko/edookit-mcp-rs/releases/download/v0.2.2/edookit-mcp_0.2.2_Darwin_arm64.tar.gz"
    sha256 "b5d890ea2fd39d35ae819daf0452f8c95c484e130baf2e3ad05716f07cf7adaa"
  end
  on_intel do
    url "https://github.com/dsaiko/edookit-mcp-rs/releases/download/v0.2.2/edookit-mcp_0.2.2_Darwin_x86_64.tar.gz"
    sha256 "1f8a34a0b5396638fea6abb1f2229e175764775834ffa78927c6380918f00955"
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
