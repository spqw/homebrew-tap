cask "alt-tab-alpha" do
  version "0.1.0-alpha"

  url "https://github.com/spqw/alt-tab-alpha/archive/refs/tags/v#{version}.tar.gz"
  sha256 :no_check

  name "AltTabAlpha"
  desc "Custom alt-tab window switcher for macOS (alpha fork)"
  homepage "https://github.com/spqw/alt-tab-alpha"

  depends_on macos: ">= :sierra"

  artifact "alt-tab-alpha-#{version}", target: "#{HOMEBREW_PREFIX}/opt/alt-tab-alpha/src"

  caveats <<~EOS
    AltTabAlpha requires building from source with Xcode.
    Source has been downloaded to: #{HOMEBREW_PREFIX}/opt/alt-tab-alpha/src

    To build:
      cd #{HOMEBREW_PREFIX}/opt/alt-tab-alpha/src
      pod install
      open alt-tab-macos.xcworkspace
      # Build and run from Xcode

    Or build from command line:
      xcodebuild -workspace alt-tab-macos.xcworkspace -scheme alt-tab-macos -configuration Release
  EOS
end
