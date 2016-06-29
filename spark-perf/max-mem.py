#!/usr/bin/env python
import sys
import re

def read_stats_log(fn):
    log = open(fn)
    times, mems = [], []
    while True:
        line = log.readline()
        if not line:
            break
        time_re = re.compile("(?P<epoch>\d+)")
        match = time_re.match(line)
        if match:
            stats_line = log.readline()
            if not stats_line:
                break
            stats_line = stats_line.split()
            mem_usage = float(stats_line[16])
            if stats_line[17] == "MB":
                mem_usage = mem_usage / 1024.0
            else:
                assert stats_line[17] == "GB"
            epoch = int(match.group("epoch"))
            times.append(epoch)
            mems.append(mem_usage)
    return times, mems

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print "usage: ./max-mem.py <stats.log>"
        sys.exit(1)
    times, mems = read_stats_log(sys.argv[1])
    print "peak memory usage: %f gb" % (max(mems),)
