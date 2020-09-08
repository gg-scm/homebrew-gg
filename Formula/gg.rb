class Gg < Formula
  desc "Git with less typing"
  homepage "https://gg-scm.io/"
  url "https://github.com/gg-scm/gg/archive/v1.0.3.tar.gz"
  sha256 "11fa3efdedcec500106696726b8d523b9e55f4834bc5d0fad7f30ed8498d14ee"
  license "Apache-2.0"
  head "https://github.com/gg-scm/gg.git"

  depends_on "go" => :build
  depends_on "pandoc" => :build
  depends_on "git" => :recommended

  def install
    ENV["GITHUB_SHA"] = "7caba4a4bea97b5beca3c54f8bc2642416c3d106"
    ENV["GO111MODULE"] = "on"
    system "release/build.bash", bin/"gg", version.to_s
    man1.mkpath
    system "pandoc", "--standalone", "--to", "man", "misc/gg.1.md", "-o", man1/"gg.1"
  end

  test do
    assert_match "1.0.3", shell_output("#{bin}/gg --version")
  end
end
