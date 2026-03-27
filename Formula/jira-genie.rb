class JiraGenie < Formula
  include Language::Python::Virtualenv

  desc "Your AI agent's interface to Jira Cloud"
  homepage "https://github.com/henriquebastos/jira-genie"
  url "https://github.com/henriquebastos/jira-genie/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "ba477375156230afbc76fbdd6f33227a1dea57d1370ceaea19d157c1fbdc3323"
  license "MIT"

  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "usage", shell_output("#{bin}/jira --help")
  end
end
