# dotfiles

Meu setup de Arch Linux + Hyprland, configurado do zero.

| Pasta | O quê |
|---|---|
| `.config/hypr` | Hyprland (config em Lua), hypridle, hyprlock, hyprpaper, hyprsunset e wallpaper |
| `.config/waybar` | barra, scripts de CPU, webcam, luz noturna (hyprsunset) e player de mídia |
| `.config/swaync` | central de notificações |
| `.config/rofi` | launcher, tema e menu do histórico da área de transferência (cliphist) |
| `.config/matugen` | modelos que geram as cores de todo o sistema a partir do wallpaper |
| `.config/gtk-3.0`, `gtk-4.0` | cores do Nautilus e dos apps GTK (geradas pelo matugen) |
| `.config/zsh` | shell em módulos: aliases, atalhos, fzf, plugins, prompt |
| `.config/kitty`, `starship.toml`, `fastfetch`, `nvim` | terminal, prompt, fetch e editor |
| `.local/bin` | `trocar-tema` e `recolorir-pastas` |

## Tema pelo wallpaper

`Super+W` (ou o botão de paleta na waybar) abre o seletor com as fotos de `~/Images/Wallpapers`. A foto escolhida vira o wallpaper e o [matugen](https://github.com/InioX/matugen) gera a paleta (esquema `tonal-spot`, modo escuro) para:

- bordas das janelas (`hypr/colors.lua`) e tela de bloqueio (`hypr/hyprlock/colors.conf`)
- kitty, waybar, rofi e swaync (cada um importa o seu `colors.*`)
- Nautilus e apps GTK3/GTK4 (`gtk.css`; o visual continua o Adwaita, só mudam as cores)
- pastas do Nautilus: `recolorir-pastas` cria o tema de ícones `Adwaita-Tema`, que herda o Adwaita e só troca o tom das pastas
- calendário `mycal` (`~/.cache/mycal/matugen.toml`)

Os arquivos `colors.*` e `gtk.css` do repo são só um ponto de partida; o `trocar-tema` reescreve todos eles. Para aplicar uma foto direto: `trocar-tema caminho/da/foto.jpg`.

## Instalar num PC novo

```sh
# dependências
yay -S hyprland hyprpaper hypridle hyprlock hyprsunset hyprshot hyprpicker waybar swaync \
  rofi rofi-power-menu kitty starship zsh zoxide fzf fd bat eza ripgrep fastfetch \
  cliphist wl-clipboard playerctl zscroll-git brightnessctl v4l-utils inotify-tools \
  bluetui nmrs btop htop pavucontrol nautilus ttf-jetbrains-mono-nerd \
  matugen adw-gtk-theme jq libnotify

# configs e scripts
git clone https://github.com/aquino-pedro/dotfiles ~/dotfiles
cp -r ~/dotfiles/.config/. ~/.config/
mkdir -p ~/.local/bin && cp ~/dotfiles/.local/bin/* ~/.local/bin/

# zsh lê a config de ~/.config/zsh
echo 'export ZDOTDIR="$HOME/.config/zsh"' >> ~/.zshenv

# GTK escuro (o adw-gtk3 aceita as cores do tema)
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
```

Os plugins do zsh não ficam no repo: `plugins.zsh` clona os que faltarem na primeira vez que o zsh abre. Para atualizá-los, `zplugin-update`.

Wallpapers não ficam no repo. Coloque as fotos em `~/Images/Wallpapers` e escolha uma com `trocar-tema`. Ele aponta `~/.config/hypr/wallpaper-atual` para a foto; o hyprpaper lê esse link ao iniciar, e o hyprlock também, depois de:

```sh
ln -s ../wallpaper-atual ~/.config/hypr/hyprlock/wallpaper
```

O módulo `custom/ycal` do waybar depende do `mycal`, que não faz parte deste repo.
