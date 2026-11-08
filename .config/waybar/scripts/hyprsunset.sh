#!/bin/sh
# Botão da waybar para o hyprsunset (filtro de luz azul).
# Ligado = segue os horários do ~/.config/hypr/hyprsunset.conf. Desligado = cor normal, sem troca automática.
# Sem argumento: imprime o estado em JSON para a waybar. Com "toggle": liga/desliga.

if [ "$1" = "toggle" ]; then
    if pgrep -x hyprsunset >/dev/null; then
        hyprctl hyprsunset identity >/dev/null 2>&1   # volta a cor normal antes de encerrar
        pkill -x hyprsunset
    else
        setsid -f hyprsunset >/dev/null 2>&1
    fi
    sleep 0.3
    pkill -RTMIN+8 -x waybar   # atualiza o ícone na hora
    exit 0
fi

if pgrep -x hyprsunset >/dev/null; then
    printf '{"text":"󰖔","class":"on","tooltip":"Luz noturna: automática (horários do hyprsunset.conf)\\nClique para desligar"}\n'
else
    printf '{"text":"󰖙","class":"off","tooltip":"Luz noturna: desligada\\nClique para religar"}\n'
fi
