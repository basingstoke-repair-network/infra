{
  flake,
  inputs,
  perSystem,
  ...
} @ args: {
  nixpkgs.hostPlatform = "aarch64-linux";
  system.stateVersion = "25.05";
}
