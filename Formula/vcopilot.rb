class Vcopilot < Formula
  desc "GitHub Copilot CLI - pipe-friendly LLM interface"
  homepage "https://github.com/spqw/lib-copilot"
  url "https://github.com/spqw/lib-copilot/releases/download/v1.0.16/vcopilot-1.0.16.tgz"
  sha256 "3bfd786c45fce6fc8552ffac06bc026d1275fda19c3d0a2d1b2062f9a9de3f76"
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
