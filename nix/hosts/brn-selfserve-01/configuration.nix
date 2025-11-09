{
  flake,
  pkgs,
  inputs,
  ...
}: {
  imports = with inputs; [
    comin.nixosModules.comin
    ./hardware-configuration.nix
  ];

  users.users = {
    dzrrodriguez = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [];
    };
    brn-kioskuser = {
      isNormalUser = true;
    };
  };

  programs.firefox.enable = true;
  services = {
    cage = {
      enable = true;
      program = "${pkgs.firefox}/bin/firefox -kiosk https://basingstoke.repair";
      user = "brn-kioskuser";
    };
    getty.loginProgram = "${pkgs.coreutils}/bin/true";
    openssh = {
      enable = true;
      settings.PermitRootLogin = "yes";
    };
    comin = {
      enable = true;
      repositorySubdir = "nix";
      remotes = [
        {
          name = "origin";
          url = "https://github.com/basingstoke-repair-network/infra.git";
          branches.main.name = "main";
        }
      ];
    };
  };
  time.timeZone = "Europe/London";
  networking = {
    networkmanager.enable = true;
    hostName = "brn-selfserve-01";
  };

  system.stateVersion = "25.11";
}
