class EdookitMcp < Formula
  desc "Unofficial MCP connector for Edookit (Czech school information system)"
  homepage "https://github.com/dsaiko/edookit-mcp"
  version "0.4.0"
  license "MIT"

  on_arm do
    url "https://github.com/dsaiko/edookit-mcp/releases/download/v0.4.0/edookit-mcp_0.4.0_Darwin_arm64.tar.gz"
    sha256 "a38b12cac3ac09c109ac60b55bc2cd27a176d98895b17e16464c92152319e06d"
  end
  on_intel do
    url "https://github.com/dsaiko/edookit-mcp/releases/download/v0.4.0/edookit-mcp_0.4.0_Darwin_x86_64.tar.gz"
    sha256 "80a751d13f99821cf066d1dd4036782de6dcdf2902a606e5e54fb4cdb96c3817"
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
