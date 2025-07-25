set quiet

default_host := "greeed"

debug-home host=default_host:
    journalctl -u home-manager-{{host}}.service --pager-end | bat

shell *pkgs:
    #!/usr/bin/env fish
    set args
    for pkg in {{pkgs}}
        switch $pkg
            case '*#*'
                set args $args $pkg
            case '*'
                set args $args nixpkgs#$pkg
        end
    end
    nix shell $args

_rebuild command host=default_host:
    nh os {{command}} . --hostname {{host}}
    # nixos-rebuild {{command}} --flake .#{{host}} # would revert to this if im not happy with nh

switch: 
    just _rebuild switch

test: 
    just _rebuild test

boot: 
    just _rebuild boot

build: 
    just _rebuild build

update:
    nix flake update

optimize:
    nix store optimize

# fix this
cd:
    #!/usr/bin/env fish
    set dir (fd --type d --hidden --exclude .git | fzf --preview='eza --tree --level=2 {} 2>/dev/null || ls -la {}')
    if test -n "$dir"
        cd $dir
    end


journal service:
    journalctl -u {{service}} -f

service:
    #!/usr/bin/env fish
    set service (systemctl list-units --type=service --all | grep -E '^\s*[^●].*\.service' | fzf --preview='systemctl status {1}' --preview-window=wrap | awk '{print $1}')
    if test -n "$service"
        set action (echo -e "status\nstart\nstop\nrestart\nenable\ndisable\nedit" | fzf --prompt="Action for $service: ")
        if test -n "$action"
            switch $action
                case "edit"
                    sudo systemctl edit $service
                case "enable" "disable" "start" "stop" "restart"
                    sudo systemctl $action $service
                case "status"
                    systemctl status $service
            end
        end
    end
