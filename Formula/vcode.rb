# typed: false
# frozen_string_literal: true

require_relative "../lib/custom_download_strategy"

class Vcode < Formula
  desc "Terminal-based AI coding agent"
  homepage "https://github.com/spqw/vcode"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/spqw/vcode/releases/download/v0.1.0/vcode-mac-x86_64.tar.gz", using: GitHubPrivateReleaseDownloadStrategy
      sha256 "a4d0d3609980a18f756c63a4732c5f5641b397da0391145cef30bcc3e0902efc"

      def install
        bin.install "vcode"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/spqw/vcode/releases/download/v0.1.0/vcode-mac-arm64.tar.gz", using: GitHubPrivateReleaseDownloadStrategy
      sha256 "850638de33ee016a87ec36c1fe75a328b2704f5b269a9495ef932bec27d1d1e9"

      def install
        bin.install "vcode"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/spqw/vcode/releases/download/v0.1.0/vcode-linux-x86_64.tar.gz", using: GitHubPrivateReleaseDownloadStrategy
      sha256 "d94667e0e2575e341c43398fcd24b01d15412bb39f6a4f38ff53dc03ddb80720"

      def install
        bin.install "vcode"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/spqw/vcode/releases/download/v0.1.0/vcode-linux-arm64.tar.gz", using: GitHubPrivateReleaseDownloadStrategy
      sha256 "3a7e802e35d692a6f6dc333a0db0a0a3a36d704ed3e6b7802316b7c5ec4093c7"

      def install
        bin.install "vcode"
      end
    end
  end
end
