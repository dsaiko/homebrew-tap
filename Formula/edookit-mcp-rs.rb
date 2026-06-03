class EdookitMcpRs < Formula
  desc "Unofficial MCP connector for Edookit (Czech school information system) — Rust port"
  homepage "https://github.com/dsaiko/edookit-mcp-rs"
  version "0.2.1"
  license "MIT"

  on_arm do
    url "https://github.com/dsaiko/edookit-mcp-rs/releases/download/v0.2.1/edookit-mcp_0.2.1_Darwin_arm64.tar.gz"
    sha256 "786b06489f36772aee80b738890613f0eb86fe925a638c0776ef3b0e4d44e3d8"
  end
  on_intel do
    url "https://github.com/dsaiko/edookit-mcp-rs/releases/download/v0.2.1/edookit-mcp_0.2.1_Darwin_x86_64.tar.gz"
    sha256 "60d8fb3cf19287dfd2f3a7c1c3eccbf42a8b21adacdc5a703845160bbcd6c8b0"
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
