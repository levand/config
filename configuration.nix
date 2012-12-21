{ config, pkgs, ... }:

{
  require =  [ ./hardware-configuration.nix ];

  powerManagement.enable = true;

  boot.initrd.kernelModules =
    [ # Specify all kernel modules that are necessary for mounting the root
      # filesystem.
      # "xfs" "ata_piix"
    ];
    
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "LB0295";
  networking.wireless.enable = true;

  fileSystems = [  
    { mountPoint = "/";
         device = "/dev/disk/by-label/NixOS";
    }
  ];

  swapDevices = [  
    { device = "/dev/sda5"; }
  ];

  services.openssh.enable = true;
  services.printing.enable = true;

  services.xserver = {
    enable = true;

    videoDrivers = ["ati" "cirrus" "intel" "vesa" "nvidia"];
     
    layout = "us";
    xkbOptions = "eurosign:e, caps:ctrl_modifier";

    windowManager.xmonad.enable = true;
    windowManager.default = "xmonad";
    desktopManager.default = "none";

  };


  users.extraUsers = {
    luke = { 
      createHome = true; 
      home = "/home/luke";
      password = "password";
      useDefaultShell = true;
      group = "users"; # required or else nix permissions are screwed up
      extraGroups = [ "wheel" ]; # wheel group is sudoers as per sudoers file
    };
  };

  fonts.enableCoreFonts = true;
  fonts.enableGhostscriptFonts = true;
  fonts.extraFonts = [ pkgs.vistafonts pkgs.dejavu_fonts ];
  
}
