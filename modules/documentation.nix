{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
    linux-manual
  ];

  documentation =  {
    enable = true;
    doc.enable = true;
    dev.enable = true;
    # info.enable = true;
    # nixos.enable = true;
    man = {
      enable = true;
      generateCaches = true;
    };
  };
}
