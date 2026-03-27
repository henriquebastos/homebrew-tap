class JiraGenie < Formula
  include Language::Python::Virtualenv

  desc "Your AI agent's interface to Jira Cloud"
  homepage "https://github.com/henriquebastos/jira-genie"
  url "https://github.com/henriquebastos/jira-genie/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "430f6a06859f10418c793003b0873ef9398b7a12bdf19dc31f7b44937311b747"
  license "MIT"

  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "usage", shell_output("#{bin}/jira --help")
  end
end
