class TermcastDemo < Formula
  desc "Feature-rich demo app showcasing termcast (Raycast for the terminal)"
  homepage "https://github.com/spqw/termcast-demo"
  license "MIT"
  version "1.0.0"

  on_linux do
    on_intel do
      url "https://github.com/spqw/termcast-demo/releases/download/v1.0.0/termcast-demo-linux-x64.tar.gz"
      sha256 "b15ca48ac12bd3eab89359a85e06468a5b860f17ea87fd94cb921935833fb070"
    end
  end

  def install
    bin.install "termcast-demo-linux-x64" => "termcast-demo"
  end

  test do
    assert_predicate bin/"termcast-demo", :exist?
  end
end
