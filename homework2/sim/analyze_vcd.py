# Analyze tb_led_flow.vcd: measure PWM duty of each LED within each flow step
import re
from collections import defaultdict

path = r"E:/xdu_fpga_course/homework2/sim/tb_led_flow.vcd"

with open(path, errors="ignore") as f:
    lines = f.read().splitlines()

# map id -> signal (only 1-bit ledr[0..7])
id2sig = {}
i = 0
in_defs = False
while i < len(lines):
    ln = lines[i].strip()
    if ln.startswith("$var"):
        parts = ln.split()
        # $var wire 1 ! ledr [3] $end
        name = parts[4]
        if name == "ledr":
            idx = int(parts[5].strip("[]")) if len(parts) > 5 else None
            if idx is not None:
                id2sig[parts[3]] = idx
    if ln.startswith("$enddefinitions"):
        break
    i += 1

# parse value changes
events = []  # (time, [(bit, val)])
t = 0
for ln in lines[i:]:
    ln = ln.strip()
    if not ln:
        continue
    if ln.startswith("#"):
        t = int(ln[1:])
    elif ln[0] in "01xz":
        vid = ln[1:]
        if vid in id2sig:
            events.append((t, id2sig[vid], 1 if ln[0] == "1" else 0))

# state per bit over time; STEP window = 1000 ns (STEP_MAX=49, clk 20ns)
STEP = 1000000
T_END = events[-1][0] if events else 0

state = [0] * 8
ev_by_time = defaultdict(list)
for tt, b, v in events:
    ev_by_time[tt].append((b, v))

# also track pos via which led has highest duty (infer later); just compute duty per (pos, led)
duty = defaultdict(lambda: defaultdict(int))  # pos -> led -> high time
wcount = defaultdict(int)                     # pos -> number of windows
t_prev = 0
times = sorted(ev_by_time.keys())
# build list of transition times
all_t = sorted(set(ev_by_time.keys()))
for tt in all_t:
    dt = tt - t_prev
    if dt <= 0:
        # apply changes at same time
        for b, v in ev_by_time[tt]:
            state[b] = v
        t_prev = tt
        continue
    # determine pos from... we can't directly; instead accumulate per absolute step window
    for w in range(t_prev // STEP, tt // STEP + 1):
        lo = max(t_prev, w * STEP)
        hi = min(tt, (w + 1) * STEP)
        if hi > lo:
            for b in range(8):
                if state[b]:
                    duty[w % 8][b] += hi - lo
    wcount[tt // STEP % 8] += 0  # windows counted below
    for b, v in ev_by_time[tt]:
        state[b] = v
    t_prev = tt

# count complete windows per pos (skip partial first/last windows)
nwin = T_END // STEP
wcount = defaultdict(int)
for w in range(nwin):
    wcount[w % 8] += 1

print("Average PWM duty of each LED when head position = pos:")
print("pos : " + " ".join(f"ledr{b:>8d}" for b in range(8)))
for p in range(8):
    n = wcount[p]
    row = " ".join(f"{duty[p][b]/(n*STEP)*100:8.2f}%" for b in range(8))
    print(f"{p:3d} : {row}")
print()
print("Expected duty if head at pos p:  led p=70/128=54.7%, p-1=35/128=27.3%, p-2=5/128=3.9%, p-3=1/128=0.8%")
