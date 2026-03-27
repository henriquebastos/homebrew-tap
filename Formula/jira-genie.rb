class JiraGenie < Formula
  include Language::Python::Virtualenv

  desc "Your AI agent's interface to Jira Cloud"
  homepage "https://github.com/henriquebastos/jira-genie"
  url "https://files.pythonhosted.org/packages/source/j/jira-genie/jira_genie-0.2.2.tar.gz"
  sha256 "5d12a09c2e45467cd9e6e48036c721f584028a745366f08ea7f3621a1fd0a7db"
  license "MIT"

  depends_on "python@3.13"

  def install
    venv = virtualenv_create(libexec, "python3.13")
    system libexec/"bin/pip", "install", "jira-genie==#{version}"
    bin.install_symlink Dir[libexec/"bin/jira"]
  end

  test do
    assert_match "usage", shell_output("#{bin}/jira --help")
  end
end
