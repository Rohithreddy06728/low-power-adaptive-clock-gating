#!/usr/bin/env bash

TIMING_DIR="/home/vsduser/Desktop/BabySoC_Simulation/src/skywater-pdk-libs-sky130_fd_sc_hd/timing"
STA="/home/vsduser/Desktop/work/tools/vsdflow/work/tools/OpenSTA/app/sta"

mkdir -p corner_reports
SUMMARY="corner_reports/clock_gating_corner_summary.txt"

printf "Corner\tWorst_Slack_ns\tTNS_ns\tStatus\n" > "$SUMMARY"

for LIB in "$TIMING_DIR"/sky130_fd_sc_hd__*.lib; do
    [ -f "$LIB" ] || continue

    NAME=$(basename "$LIB" .lib)
    CORNER=${NAME#sky130_fd_sc_hd__}

    sed "s|^read_liberty .*|read_liberty $LIB|" run_sta.tcl \
        > "corner_reports/run_${CORNER}.tcl"

    "$STA" -exit "corner_reports/run_${CORNER}.tcl" \
        > "corner_reports/sta_${CORNER}.log" 2>&1

    if grep -q "^Error:" "corner_reports/sta_${CORNER}.log"; then
        printf "%s\t-\t-\tCHECK_LOG\n" "$CORNER" >> "$SUMMARY"
    else
        SLACK=$(grep 'worst slack ' "corner_reports/sta_${CORNER}.log" | tail -1 | awk '{print $3}')
        TNS=$(grep '^tns ' "corner_reports/sta_${CORNER}.log" | tail -1 | awk '{print $2}')

        if [ -n "$SLACK" ] && [ -n "$TNS" ]; then
            printf "%s\t%s\t%s\tOK\n" "$CORNER" "$SLACK" "$TNS" >> "$SUMMARY"
        else
            printf "%s\t-\t-\tCHECK_LOG\n" "$CORNER" >> "$SUMMARY"
        fi
    fi
done

echo
echo "===== CLOCK-GATING PVT SWEEP SUMMARY ====="
column -t -s $'\t' "$SUMMARY"
