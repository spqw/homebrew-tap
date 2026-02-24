# typed: false
# frozen_string_literal: true

require "download_strategy"
require "json"

class GitHubPrivateReleaseDownloadStrategy < CurlDownloadStrategy
  def initialize(url, name, version, **meta)
    super
    parse_url_pattern
    set_github_token
  end

  def parse_url_pattern
    url_pattern = %r{https://github.com/([^/]+)/([^/]+)/releases/download/([^/]+)/(\S+)}
    unless @url =~ url_pattern
      raise CurlDownloadStrategyError, "Invalid url pattern for GitHub Release."
    end

    _, @owner, @repo, @tag, @filename = *@url.match(url_pattern)
  end

  def download_url
    "https://api.github.com/repos/#{@owner}/#{@repo}/releases/assets/#{asset_id}"
  end

  def _fetch(url:, resolved_url:, timeout:)
    curl_download download_url,
                  "--header", "Accept: application/octet-stream",
                  "--header", "Authorization: token #{@github_token}",
                  "--location",
                  to: temporary_path
  end

  private

  def set_github_token
    @github_token = ENV["HOMEBREW_GITHUB_API_TOKEN"]
    unless @github_token
      raise CurlDownloadStrategyError,
            "HOMEBREW_GITHUB_API_TOKEN is required. Set it to a GitHub PAT with 'repo' scope."
    end
  end

  def asset_id
    @asset_id ||= resolve_asset_id
  end

  def resolve_asset_id
    release_url = "https://api.github.com/repos/#{@owner}/#{@repo}/releases/tags/#{@tag}"
    output, = curl_output(
      "--header", "Authorization: token #{@github_token}",
      "--header", "Accept: application/vnd.github+json",
      release_url,
    )
    metadata = JSON.parse(output)
    raise CurlDownloadStrategyError, "GitHub API error: #{metadata["message"]}" if metadata["message"]

    assets = metadata["assets"]&.select { |a| a["name"] == @filename }
    raise CurlDownloadStrategyError, "Asset '#{@filename}' not found in release #{@tag}." if assets.nil? || assets.empty?

    assets.first["id"]
  end
end

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
