{ config, pkgs, lib, currentSystem, currentSystemName,... }:

{
  # Be careful updating this.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # use unstable nix so we can access flakes
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
   };

  # We expect to run the VM on hidpi machines.
  # hardware.video.hidpi.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # VMware, Parallels both only support this being 0 otherwise you see
  # "error switching console mode" on boot.
  boot.loader.systemd-boot.consoleMode = "0";

  # Define your hostname.
  networking.hostName = "atlas";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  # Don't require password for sudo
  security.sudo.wheelNeedsPassword = false;

  # Virtualization settings
  virtualisation.docker.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # setup windowing environment
  # services.xserver = {
  #   enable = true;
  #   layout = "us";
  #   dpi = 220;

  #   desktopManager = {
  #     xterm.enable = false;
  #     wallpaper.mode = "fill";
  #   };

  #   displayManager = {
  #     defaultSession = "none+i3";
  #     lightdm.enable = true;

  #     # AARCH64: For now, on Apple Silicon, we must manually set the
  #     # display resolution. This is a known issue with VMware Fusion.
  #     sessionCommands = ''
  #       ${pkgs.xorg.xset}/bin/xset r rate 200 40
  #     '' + (if currentSystemName == "vm-aarch64" then ''
  #       ${pkgs.xorg.xrandr}/bin/xrandr -s '2880x1800'
  #     '' else "");
  #   };

  #   windowManager = {
  #     i3.enable = true;
  #   };
  # };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;

  # Manage fonts. We pull these from a secret directory since most of these
  # fonts require a purchase.
  # fonts = {
  #   fontDir.enable = true;

  #   fonts = [
  #     pkgs.fira-code
  #   ];
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gnumake
    killall
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = true;
  services.openssh.permitRootLogin = "yes";

  # Disable the firewall since we're in a VM and we want to make it
  # easy to visit stuff in here. We only use NAT networking anyways.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
