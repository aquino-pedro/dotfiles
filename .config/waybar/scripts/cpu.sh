#!/bin/bash
# Calcula o uso real de CPU (total e por thread) lendo /proc/stat

mapfile -t stat1 < <(grep '^cpu' /proc/stat)
sleep 1
mapfile -t stat2 < <(grep '^cpu' /proc/stat)

calc_usage() {
    local line1="$1" line2="$2"
    read -r _ a1 b1 c1 idle1 iowait1 irq1 softirq1 steal1 _ <<< "$line1"
    read -r _ a2 b2 c2 idle2 iowait2 irq2 softirq2 steal2 _ <<< "$line2"
    local total1=$((a1 + b1 + c1 + idle1 + iowait1 + irq1 + softirq1 + steal1))
    local total2=$((a2 + b2 + c2 + idle2 + iowait2 + irq2 + softirq2 + steal2))
    local totald=$((total2 - total1))
    local idled=$(((idle2 + iowait2) - (idle1 + iowait1)))
    if [ "$totald" -le 0 ]; then
        echo 0
        return
    fi
    echo $(((100 * (totald - idled)) / totald))
}

overall=$(calc_usage "${stat1[0]}" "${stat2[0]}")

tooltip="Total: ${overall}%"
core=0
for i in "${!stat1[@]}"; do
    [ "$i" -eq 0 ] && continue
    usage=$(calc_usage "${stat1[$i]}" "${stat2[$i]}")
    tooltip="${tooltip}\nCore${core}: ${usage}%"
    core=$((core + 1))
done

class="low"
if [ "$overall" -ge 80 ]; then
    class="high"
elif [ "$overall" -ge 50 ]; then
    class="medium"
fi

echo "{\"text\": \"${overall}%\", \"tooltip\": \"${tooltip}\", \"class\": \"${class}\", \"percentage\": ${overall}}"
