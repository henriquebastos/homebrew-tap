class JiraGenie < Formula
  desc "Your AI agent's interface to Jira Cloud"
  homepage "https://github.com/henriquebastos/jira-genie"
  url "https://github.com/henriquebastos/jira-genie/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "5f4996172c7159c23a5caab3214d032988cb8081e4da35321700ffa83f916909"
  license "MIT"

  depends_on "python@3.14"

  def install
    python3 = Formula["python@3.14"].opt_bin/"python3.14"
    system python3, "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--no-cache-dir", "jira-genie==#{version}"
    bin.install_symlink Dir[libexec/"bin/jira"]
  end

  test do
    assert_match "usage", shell_output("#{bin}/jira --help")
  end
end
