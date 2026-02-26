class Vcopilot < Formula
  desc "GitHub Copilot CLI - pipe-friendly LLM interface"
  homepage "https://github.com/spqw/lib-copilot"
  url "https://github.com/spqw/lib-copilot/releases/download/v1.0.17/vcopilot-1.0.17.tgz"
  sha256 "296273c682af44b7d143bbb28f1a854a19365d3d4f166930ca3ce25c8f23f4d6"
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
