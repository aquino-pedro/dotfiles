#!/bin/bash
# Controla auto_exposure/exposure_time_absolute da webcam "HD User Facing"
# para evitar que ela caia pra ~1fps em ambientes com pouca luz.

DEV=$(v4l2-ctl --list-devices 2>/dev/null | awk '/HD User Facing/{getline; print $1; exit}')
[ -z "$DEV" ] && DEV="/dev/video1"

STEP=100
MIN=50
MAX=1000    # 1000 = 100ms/frame = 10fps, teto seguro (nunca deixa cair pra 1fps)
DEFAULT_MANUAL=300

get_ctrl() {
    v4l2-ctl -d "$DEV" --get-ctrl="$1" 2>/dev/null | awk -F': ' '{print $2}' | awk '{print $1}'
}

case "$1" in
  toggle)
    auto=$(get_ctrl auto_exposure)
    if [ "$auto" = "3" ]; then
        v4l2-ctl -d "$DEV" --set-ctrl=auto_exposure=1,exposure_time_absolute=$DEFAULT_MANUAL >/dev/null 2>&1
    else
        v4l2-ctl -d "$DEV" --set-ctrl=auto_exposure=3 >/dev/null 2>&1
    fi
    exit 0
    ;;
  inc)
    exp=$(get_ctrl exposure_time_absolute)
    newexp=$((exp + STEP))
    [ "$newexp" -gt "$MAX" ] && newexp=$MAX
    v4l2-ctl -d "$DEV" --set-ctrl=auto_exposure=1,exposure_time_absolute=$newexp >/dev/null 2>&1
    exit 0
    ;;
  dec)
    exp=$(get_ctrl exposure_time_absolute)
    newexp=$((exp - STEP))
    [ "$newexp" -lt "$MIN" ] && newexp=$MIN
    v4l2-ctl -d "$DEV" --set-ctrl=auto_exposure=1,exposure_time_absolute=$newexp >/dev/null 2>&1
    exit 0
    ;;
esac

auto=$(get_ctrl auto_exposure)
exp=$(get_ctrl exposure_time_absolute)

if [ "$auto" = "3" ]; then
    text="󰄀 Auto"
    class="auto"
    tooltip="Webcam: exposição automática (pode cair p/ 1fps em pouca luz)\nClique: fixar exposição manual"
else
    text="󰄀 ${exp}"
    class="manual"
    tooltip="Webcam: exposição manual fixa em ${exp}\nScroll: ajustar | Clique: voltar ao automático"
fi

echo "{\"text\": \"${text}\", \"tooltip\": \"${tooltip}\", \"class\": \"${class}\"}"
