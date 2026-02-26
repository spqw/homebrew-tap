class Vcopilot < Formula
  desc "GitHub Copilot CLI - pipe-friendly LLM interface"
  homepage "https://github.com/spqw/lib-copilot"
  url "https://github.com/spqw/lib-copilot/releases/download/v1.0.14/vcopilot-1.0.14.tgz"
  sha256 "5d5578bd492e8664758cddd9fe8ed6cb814f85b60823ec657999788f655c1b0b"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", "--production", *std_npm_args
    bin.install_symlink libexec/"bin/vcopilot"
  end

  test do
    assert_match "vcopilot", shell_output("#{bin}/vcopilot --help 2>&1", 0)
  end
end
