{ config, lib, ... }:

{
  options = {
    samba.enable = lib.mkEnableOption "Enables samba";
  };

  config = lib.mkIf config.samba.enable {

    services.samba = {
      enable = true;
      securityType = "user";
      openFirewall = true;
      extraConfig = ''
        workgroup = WORKGROUP
        server string = smbnix
        netbios name = smbnix
        security = user
        use sendfile = yes
        # note: localhost is the ipv6 localhost ::1
        hosts allow = 192.168.0.72 192.168.0.77 127.0.0.1 localhost
        hosts deny = 0.0.0.0/0
        guest account = nobody
        map to guest = bad user
      '';
      shares = {
        public = {
          path = "/mnt/Shares/public/";
          browseable = "yes";
          "read only" = "no";
          "guest ok" = "yes";
          "create mask" = "0664";
          "directory mask" = "0775";
          "force user" = "smbuser";
          "force group" = "samba";
        };
        private = {
          path = "/mnt/Shares/private/";
          browseable = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0664";
          "directory mask" = "0775";
          "force user" = "bart";
          "force group" = "samba";
        };
      };
    };

    services.samba-wsdd = {
      enable = true;
      openFirewall = true;
    };

  };
}
