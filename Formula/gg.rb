# Copyright 2020 The gg Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

class Gg < Formula
  desc "Git with less typing"
  homepage "https://gg-scm.io/"
  url "https://github.com/gg-scm/gg/archive/v1.3.1.tar.gz"
  sha256 "c749467620783a00a59ccba910bba0a4654c3a3cf2d6293836f0f672588b9f36"
  license "Apache-2.0"
  head "https://github.com/gg-scm/gg.git", branch: "main"

  depends_on "go" => :build
  depends_on "pandoc" => :build
  depends_on "git" => :recommended

  def install
    ENV["GITHUB_SHA"] = "b6be8bac78605c21a9670db0e44faf5e1eafe0d4"
    ENV["GO111MODULE"] = "on"
    system "release/build.bash", bin/"gg", version.to_s
    man1.mkpath
    system "pandoc", "--standalone", "--to", "man", "misc/gg.1.md", "-o", man1/"gg.1"
    bash_completion.mkpath
    copy "misc/gg.bash", bash_completion/"gg"
    zsh_completion.mkpath
    copy "misc/_gg.zsh", zsh_completion/"_gg"
  end

  test do
    assert_match "1.3.1", shell_output("#{bin}/gg --version")
  end
end
