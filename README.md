# dotfiles

Meu setup de Arch Linux + Hyprland, configurado do zero.

| Pasta | O quê |
|---|---|
| `.config/hypr` | Hyprland (config em Lua), hypridle, hyprlock, hyprpaper, hyprsunset e wallpaper |
| `.config/waybar` | barra, scripts de CPU, webcam e player de mídia |
| `.config/swaync` | central de notificações |
| `.config/rofi` | launcher, tema e menu do histórico da área de transferência (cliphist) |
| `.config/zsh` | shell em módulos: aliases, atalhos, fzf, plugins, prompt |
| `.config/kitty`, `starship.toml`, `fastfetch`, `nvim` | terminal, prompt, fetch e editor |

## Instalar num PC novo

```sh
# dependências
yay -S hyprland hyprpaper hypridle hyprlock hyprsunset hyprshot waybar swaync \
  rofi rofi-power-menu kitty starship zsh zoxide fzf fd bat eza ripgrep fastfetch \
  cliphist wl-clipboard playerctl zscroll-git brightnessctl v4l-utils inotify-tools \
  bluetui nmrs btop htop pavucontrol nautilus ttf-jetbrains-mono-nerd

# configs
git clone https://github.com/aquino-pedro/dotfiles ~/dotfiles
cp -r ~/dotfiles/.config/. ~/.config/

# zsh lê a config de ~/.config/zsh
echo 'export ZDOTDIR="$HOME/.config/zsh"' >> ~/.zshenv
```

Os plugins do zsh não ficam no repo: `plugins.zsh` clona os que faltarem na primeira vez que o zsh abre. Para atualizá-los, `zplugin-update`.

Wallpapers não ficam no repo. Coloque a imagem em `~/.config/hypr/hyprpaper/wallpapers/montanha.jpg` (ou ajuste `hyprpaper.conf`) e aponte o hyprlock para ela:

```sh
ln -s ../hyprpaper/wallpapers/montanha.jpg ~/.config/hypr/hyprlock/wallpaper
```

O módulo `custom/ycal` do waybar depende do `mycal`, que não faz parte deste repo.
