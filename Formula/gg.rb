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
  url "https://github.com/gg-scm/gg/archive/v1.0.3.tar.gz"
  sha256 "29f309181f37f27c262508a8447bfbe93ebccaee80ba96e76690b292b4f5e22d"
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
