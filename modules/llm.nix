{pkgs, ...}:
# parameters from: https://huggingface.co/Qwen/Qwen3.5-9B#best-practices
let
  models = pkgs.writeText "models.ini" ''
    [Qwen3.5-9B]
    hf-repo = bartowski/Qwen_Qwen3.5-9B-GGUF
    hf-file = Qwen_Qwen3.5-9B-Q8_0.gguf
    alias = Qwen3.5-9B
    temp = 1.0
    top-p = 0.95
    top-k = 20
    presence-penalty = 1.5
  '';
in {
  boot.initrd.kernelModules = ["amdgpu"];

  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp-rocm;

    settings = {
      models-preset = "${models}";
    };
  };
}
