{host, ...}: {
  services = {
    rpcbind.enable = host.enableNFS;
    nfs.server.enable = host. enableNFS;
  };
}
