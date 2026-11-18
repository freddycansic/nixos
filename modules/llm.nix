{pkgs, ...}: {
  environment.systemPackages = [pkgs.ollama-rocm];

  boot.initrd.kernelModules = ["amdgpu"];

  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    loadModels = ["qwen3.5:9b-q8_0"];
    environmentVariables = {
      HCC_AMDGPU_TARGET = "gfx1030";
    };
  };
}
