class Vcopilot < Formula
  desc "GitHub Copilot CLI - pipe-friendly LLM interface"
  homepage "https://github.com/spqw/lib-copilot"
  url "https://github.com/spqw/lib-copilot/releases/download/v1.0.6/vcopilot-1.0.6.tgz"
  sha256 "15ab7fda44351ce74ec7e689b5538a0e3a43a11e9dfdc2a2241bfd32218508a2"
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
