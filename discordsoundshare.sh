#!/bin/bash
pactl load-module module-null-sink sink_name=Virtual1
pactl load-module module-loopback source=[NAME OF MIC] sink=Virtual1
pactl load-module module-loopback source=Virtual1.monitor sink=[NAME OF OUTPUT]
pactl load-module module-combine-sink sink_name=nullandmain slaves=[NAME OF OUTPUT],Virtual1
