class EdookitMcp < Formula
  desc "Unofficial MCP connector for Edookit (Czech school information system)"
  homepage "https://github.com/dsaiko/edookit-mcp"
  version "0.3.0"
  license "MIT"

  on_arm do
    url "https://github.com/dsaiko/edookit-mcp/releases/download/v0.3.0/edookit-mcp_0.3.0_Darwin_arm64.tar.gz"
    sha256 "160d70af2ea5c0822905adf4c48085929d68f2ecfd489a1decc5a66a354feff8"
  end
  on_intel do
    url "https://github.com/dsaiko/edookit-mcp/releases/download/v0.3.0/edookit-mcp_0.3.0_Darwin_x86_64.tar.gz"
    sha256 "d25272d739e8644807b71fa1fee83856350f8819edf73ca9ad6f2e4bbcdca31f"
  end

  def install
    # Keep the binary and its bundled libpdfium together so the exe-dir
    # PDFium resolution works; symlink the binary onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"edookit-mcp" => "edookit-mcp"
  end

  def caveats
    <<~EOS
      Drives a real Chromium/Chrome instance once per ~10h to log into Plus4U,
      so install a Chromium-family browser. Configure via
      EDOOKIT_URL / EDOOKIT_USER / EDOOKIT_PASS. PDF attachment rasterization
      uses the bundled libpdfium installed next to the binary.
    EOS
  end

  test do
    assert_match "required env var", shell_output("#{bin}/edookit-mcp 2>&1", 1)
  end
end
