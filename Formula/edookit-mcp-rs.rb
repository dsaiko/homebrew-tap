class EdookitMcpRs < Formula
  desc "Unofficial MCP connector for Edookit (Czech school information system) — Rust port"
  homepage "https://github.com/dsaiko/edookit-mcp-rs"
  version "0.1.0"
  license "MIT"

  on_arm do
    url "https://github.com/dsaiko/edookit-mcp-rs/releases/download/v0.1.0/edookit-mcp_0.1.0_Darwin_arm64.tar.gz"
    sha256 "7ba75bae1c3e86ce253d9b16a841a6ea3d73eb007fa4e4724d6da9292109b7f0"
  end
  on_intel do
    url "https://github.com/dsaiko/edookit-mcp-rs/releases/download/v0.1.0/edookit-mcp_0.1.0_Darwin_x86_64.tar.gz"
    sha256 "efa98ff2cafbcd5aa7cba4d427e3178c69edb6b5a72087a02b08524b036bcfec"
  end

  def install
    # Keep the binary and its bundled libpdfium together so the exe-dir PDFium
    # resolution works; symlink onto PATH as `edookit-mcp-rs` so it can coexist
    # with the Go build's `edookit-mcp` from the same tap.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"edookit-mcp" => "edookit-mcp-rs"
  end

  def caveats
    <<~EOS
      Installs as `edookit-mcp-rs` (the Go build installs as `edookit-mcp`).
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
