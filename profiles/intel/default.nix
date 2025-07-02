{host, ...}: {
  imports = [
    ../../modules/drivers
  ];
  drivers.intel.enable = true;
}
