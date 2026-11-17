{pkgs, ...}: {
  environment.systemPackages = [pkgs.ollama-rocm];

  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    loadModels = ["qwen3.5:9b-q8_0"];
  };
}
