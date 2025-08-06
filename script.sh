#!/usr/bin/env bash

if [ ! -f "docs/index.html" ]; then
	if [ ! -d "docs" ]; then
		mkdir "docs"
	fi
	touch "docs/index.html"
fi

echo "<h1>Devops Dashboard</h1>" > "docs/index.html"

add_to_file() {
	echo "<p>$1</p>" >> "docs/index.html"
}

host=$(hostname)
add_to_file "Host: $host"

day=$(date +%Y-%m-%d)
hours=$(date +%H:%M:%S)
time_now="${day} ${hours}"
add_to_file "Time: $time_now"

cpu=`top -bn1 | awk '/Cpu\(s\):/ {printf "%.1f%%\n", $2 + $4}'`
add_to_file "CPU: $cpu"

total=$(free -m | awk '/^Память:/ {print $2}')
used=$(free -m | awk '/^Память:/ {print $3}')
percent=$((used * 100 / total))
add_to_file "Memory: $percent% used"

diskp=$(df / -h | awk 'NR == 2 {print $5}')
add_to_file "Disk: $diskp used"
