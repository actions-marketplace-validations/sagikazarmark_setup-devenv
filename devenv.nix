{ pkgs, ... }:

{
  packages = with pkgs; [
    actionlint
  ];

  # Used by CI to check that the profile input reaches later steps.
  profiles.ci.module = {
    env.SETUP_DEVENV_PROFILE = "ci";
  };
}
