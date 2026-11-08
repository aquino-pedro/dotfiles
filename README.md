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
| `.config/kitty`, `starship.toml`, `nvim` | terminal, prompt e editor |
| `.config/fastfetch`, `.config/fetch` | info do sistema ao abrir o terminal: fastfetch ou [fetch](https://github.com/areofyl/fetch) (logo do Arch girando em 3D) |
| `.local/bin` | `trocar-tema`, `recolorir-pastas` e `trocar-logo` |

## Tema pelo wallpaper

`Super+W` (ou o botão de paleta na waybar) abre o seletor com as fotos de `~/Images/Wallpapers`. A foto escolhida vira o wallpaper e o [matugen](https://github.com/InioX/matugen) gera a paleta (esquema `tonal-spot`, modo escuro) para:

- bordas das janelas (`hypr/colors.lua`) e tela de bloqueio (`hypr/hyprlock/colors.conf`)
- kitty, waybar, rofi e swaync (cada um importa o seu `colors.*`)
- Nautilus e apps GTK3/GTK4 (`gtk.css`; o visual continua o Adwaita, só mudam as cores)
- pastas do Nautilus: `recolorir-pastas` cria o tema de ícones `Adwaita-Tema`, que herda o Adwaita e só troca o tom das pastas
- calendário `mycal` (`~/.cache/mycal/matugen.toml`)
- prompt do Starship, fastfetch e fetch (logo e nomes na cor principal)

Os arquivos `colors.*` e `gtk.css` do repo são só um ponto de partida; o `trocar-tema` reescreve todos eles. O mesmo vale para `starship.toml`, `fastfetch/config.jsonc` e `fetch/config`, que são gerados inteiros: para mudar algo neles, edite o modelo em `.config/matugen/templates/`. Para aplicar uma foto direto: `trocar-tema caminho/da/foto.jpg`.

## Terminal: fastfetch, fetch 3D e logos

Ao abrir o terminal roda o fastfetch ou o fetch 3D. Para alternar: `fetch-modo fetch` ou `fetch-modo fastfetch` (vale para o próximo terminal).

Os logos do fastfetch são os `.txt` de `.config/fastfetch` (`logo-arch-*` são versões do Arch em blocos, com os entalhes). O fastfetch lê o link `logo-atual.txt`; `trocar-logo` lista os logos e `trocar-logo arch-largo10` troca. Qualquer `.txt` novo na pasta entra na lista.

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

# fetch 3D (opcional): compila para o usuário, sem sudo
git clone https://github.com/areofyl/fetch /tmp/fetch && make -C /tmp/fetch install PREFIX=~/.local

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
