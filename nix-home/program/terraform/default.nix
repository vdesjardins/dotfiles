{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    terraform_0_13
  ];

  programs.fish.shellAbbrs = {
    tf = "terraform";
    tfa = "terraform apply";
    tfat = "terraform apply -target=";
    tfp = "terraform plan";
    tfpt = "terraform plan -target=";
    tfi = "terraform init";
    tfsl = "terraform state list";
  };
}
