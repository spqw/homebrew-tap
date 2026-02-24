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
      release_url,
      "--header", "Authorization: token #{@github_token}",
      "--header", "Accept: application/vnd.github+json",
    )
    metadata = JSON.parse(output)
    assets = metadata["assets"]&.select { |a| a["name"] == @filename }
    raise CurlDownloadStrategyError, "Asset '#{@filename}' not found in release #{@tag}." if assets.nil? || assets.empty?

    assets.first["id"]
  end
end
