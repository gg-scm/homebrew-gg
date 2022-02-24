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
  url "https://github.com/gg-scm/gg/archive/v1.2.0.tar.gz"
  sha256 "741df022a1583d17fd1bf4fca1b15d305796f91a22d436a034288f47e662898a"
  license "Apache-2.0"
  head "https://github.com/gg-scm/gg.git", branch: "main"

  depends_on "go" => :build
  depends_on "pandoc" => :build
  depends_on "git" => :recommended

  def install
    ENV["GITHUB_SHA"] = "4c319a5f46f9b89b9ea2163931015a089d22c89c"
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
    assert_match "1.2.0", shell_output("#{bin}/gg --version")
  end
end
