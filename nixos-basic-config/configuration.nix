# BASICS START
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "server"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Sarajevo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "bs_BA.UTF-8";
    LC_IDENTIFICATION = "bs_BA.UTF-8";
    LC_MEASUREMENT = "bs_BA.UTF-8";
    LC_MONETARY = "bs_BA.UTF-8";
    LC_NAME = "bs_BA.UTF-8";
    LC_NUMERIC = "bs_BA.UTF-8";
    LC_PAPER = "bs_BA.UTF-8";
    LC_TELEPHONE = "bs_BA.UTF-8";
    LC_TIME = "bs_BA.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vedo = {
    isNormalUser = true;
    description = "vedad";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  wget
  docker-compose
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # FIREWALL
  # networking.firewall.allowedTCPPorts = [ 9443 80 81 443 53 3000 ];
  # networking.firewall.allowedUDPPorts = [ 9443 80 81 443 53 3000 ];

  system.stateVersion = "24.11";
# BASICS END

# My Setup

# Docker
virtualisation.docker.enable = true;

# SAMBA START
 services.samba = {
   enable = true;
   openFirewall = true;
   shares = {
     sharebigboi = {
       path = "/mnt";
       browseable = true;
       writable = true;
       guestOk = true;
     };
   };
 };
# SAMBA END


}
