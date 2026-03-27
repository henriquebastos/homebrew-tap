class JiraGenie < Formula
  desc "Your AI agent's interface to Jira Cloud"
  homepage "https://github.com/henriquebastos/jira-genie"
  url "https://github.com/henriquebastos/jira-genie/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "eb175492d2717b50e195b751a9edf8c9cfc4a859551a2fb68855e61344f9bccd"
  license "MIT"

  depends_on "python@3.13"

  def install
    python3 = Formula["python@3.13"].opt_bin/"python3.13"
    system python3, "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--no-cache-dir", "jira-genie==#{version}"
    bin.install_symlink Dir[libexec/"bin/jira"]
  end

  test do
    assert_match "usage", shell_output("#{bin}/jira --help")
  end
end
