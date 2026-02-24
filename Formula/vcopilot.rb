class Vcopilot < Formula
  desc "GitHub Copilot CLI - pipe-friendly LLM interface"
  homepage "https://github.com/spqw/lib-copilot"
  url "https://github.com/spqw/lib-copilot/releases/download/v1.0.8/vcopilot-1.0.8.tgz"
  sha256 "096975bd2a1ec8e285c5cb3aea7047f8cc076fd10bb3f921c7ebbbd0d0dfb15b"
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
