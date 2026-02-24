cask "observable-mac" do
  version "0.1.0"

  on_arm do
    sha256 "PLACEHOLDER"
    url "https://github.com/spqw/observable-mac/releases/download/v#{version}/Observable.Mac_#{version}_aarch64.dmg"
  end

  on_intel do
    sha256 "PLACEHOLDER"
    url "https://github.com/spqw/observable-mac/releases/download/v#{version}/Observable.Mac_#{version}_x64.dmg"
  end

  name "Observable Mac"
  desc "Observable Framework desktop viewer"
  homepage "https://github.com/spqw/observable-mac"

  app "Observable Mac.app"

  caveats <<~EOS
    This app is unsigned. On first launch:
    1. Right-click the app in Finder
    2. Select "Open"
    3. Click "Open" in the security dialog
  EOS
end
