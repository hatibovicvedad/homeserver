{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/ccbcecf9-70cb-4e5a-ae7f-db01a999a35c";
      fsType = "ext4";
    };

# MOUNT START

# ssd
  fileSystems."/mnt/ssd" =
    { device = "/dev/disk/by-uuid/8c8620fe-70be-488b-bb4e-b96235cd43aa";
      fsType = "ext4";
    };

# hdd
  fileSystems."/mnt/hdd" =
    { device = "/dev/disk/by-uuid/0c821c31-8456-4614-85b3-fe7dae18f61b";
      fsType = "ext4";
    };

# MOUNT END

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
