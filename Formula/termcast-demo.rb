class TermcastDemo < Formula
  desc "Feature-rich demo app showcasing termcast (Raycast for the terminal)"
  homepage "https://github.com/spqw/termcast-demo"
  license "MIT"
  version "1.0.0"

  on_macos do
    on_arm do
      url "https://github.com/spqw/termcast-demo/releases/download/v1.0.0/termcast-demo-darwin-arm64.zip"
      sha256 "25faa579eeafcccfc356ac4d8e5dfe1332b2379355771f1c880ef03711277027"

      def install
        bin.install "termcast-demo-darwin-arm64" => "termcast-demo"
      end
    end

    on_intel do
      url "https://github.com/spqw/termcast-demo/releases/download/v1.0.0/termcast-demo-darwin-x64.zip"
      sha256 "c1fb57a032fbb43563b9c82a39b5eeda37dec1c403bca88e100a3a7dd1b65c44"

      def install
        bin.install "termcast-demo-darwin-x64" => "termcast-demo"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/spqw/termcast-demo/releases/download/v1.0.0/termcast-demo-linux-arm64.tar.gz"
      sha256 "b69a347cf13015ec333cb5cbe155c3b5e342b30da60781164dfb3f08606968f3"

      def install
        bin.install "termcast-demo-linux-arm64" => "termcast-demo"
      end
    end

    on_intel do
      url "https://github.com/spqw/termcast-demo/releases/download/v1.0.0/termcast-demo-linux-x64.tar.gz"
      sha256 "aff570e87a076dfe22b6970f4266cdba40e7219dc3cc8b5b53e45453c11ecb39"

      def install
        bin.install "termcast-demo-linux-x64" => "termcast-demo"
      end
    end
  end

  test do
    assert_predicate bin/"termcast-demo", :exist?
  end
end
