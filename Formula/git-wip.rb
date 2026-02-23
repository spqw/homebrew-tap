class GitWip < Formula
  desc "List recent git branches across workspaces, detect dirty/unpushed state, batch-commit to WIP branches"
  homepage "https://github.com/spqw/git-wip"
  url "https://github.com/spqw/git-wip.git", branch: "main"
  version "0.2.0"
  license "MIT"

  depends_on "node"
  depends_on "pnpm"

  def install
    system "pnpm", "install", "--frozen-lockfile"
    libexec.install Dir["*"]
    libexec.install ".gitignore"

    # Create wrapper that uses the bundled tsx
    (bin/"git-wip").write <<~BASH
      #!/usr/bin/env bash
      exec "#{libexec}/node_modules/.bin/tsx" "#{libexec}/src/cli.ts" "$@"
    BASH
    chmod 0755, bin/"git-wip"
  end

  test do
    assert_match "0.2.0", shell_output("#{bin}/git-wip --version")
  end
end
