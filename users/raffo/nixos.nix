{ pkgs, ... }:

{
  # https://github.com/nix-community/home-manager/pull/2408
  # environment.pathsToLink = [ "/share/fish" ];

  users.users.raffo = {
    isNormalUser = true;
    home = "/home/raffo";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.zsh;
    password = "root";
    # hashedPassword = "$6$p5nPhz3G6k$6yCK0m3Oglcj4ZkUXwbjrG403LBZkfNwlhgrQAqOospGJXJZ27dI84CbIYBNsTgsoH650C1EBsbCKesSVPSpB1";
    # openssh.authorizedKeys.keys = [
    #   "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCoOV8m33AZZlB6m8cvoGncmnpm27Z6qa3En2u61d1yZ038rpxkAcYRqGUMoe/llr8xYZYb147NrEhqlXDGpisTNEIYoNFe0VY3M7nh0ZAm3biujCBKL301BZJrsFcZeo1FtfD1GLpkgEcScZD/uubYe+7LMu2BgZ+9qANp7bN5bqdrdqfZcueiryW7YT7tzHJD7DaVpsrXVXvi8+dgAu5EP8vXZ4Ju2rVihXhWZcslQF/47Aqel7zVzfxJ5hx4tI4z4+hWrr3q1yXdwuEcdM5UpA9HN9nihLmkdNTGlSMOt+6Ckd5gBZNBGW7edLSK8SdBarU0VeaHHRQcS7/K+uIHkJ4ove65xVoPvGuBjXas63qYUsbzG4+1RTgrFhbQBGjkbyaMO7lMpNA0HgnF30z2mUL4sXSFuOixZeFJrLFchGMqvW7sE7I7UXGWuDxhTMZVNx4l7Kj7pMjaNaQ1tnpF6u/6AxLRsYZA1i3eEBtd0LxvCdiSYoo5dYaAWRS785PjgTjcv8VEYHu9ZE59RXz9DIOjx3Q4IrYzaPzgB7hycKh0Qh+gZsLhpfONCUqMMKARHSFq+U4/De5CMuG/WzZ+VcVfPISilkWf6BfAZN8DGGzPUioW9U0jKkbzUUImocbz7Fe8lIbyy40Ng/syxVLtNjcnS+sqRsjoZ3dmhoagOw== raffo@github.com"
    # ];
  };

  #nixpkgs.overlays = import ../../lib/overlays.nix ++ [
  #  (import ./vim.nix)
  #];
}
