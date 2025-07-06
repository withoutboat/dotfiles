{config, ...}: {
 home.sessionVariables = {
    GITHUB_TOKEN = builtins.readFile "${config.home.homeDirectory}/.local/github_token";
  };
  }
