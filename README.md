# kubectl-profiler

Run profiler and generate flame graph(perf, bpf, offcpu, etc.) on a process of a container with kubectl plugin

## Install

### Local Install

First make sure you have already installed kubectl.

```bash
# clone this repo
git clone https://github.com/major1201/kubectl-profiler.git

# make a link from kubectl-profiler to one of your $PATH
ln -s ./kubectl-profiler /usr/local/bin/kubectl-profiler
```

## Usage

```
Usage: kubectl profiler [parameters]
Parameters:
  -h,--help          show this help message
  -n,--namespace     specify namespace
  -c,--container     specify container name
  -s,--scheme        specify profiling scheme, choices: [perf(default), bpf, offcpu, page_fault, python]
  -D,--duration      profiling duration, default 30
  --image            use a custom image, default: major1201/profiler-generic:latest
  -node,--nodename   node name
  -p,--pid           pid
  -o,--output        output file, default: flame.svg
  --extra-arguments  append extra perf record arguments
```

Examples

```bash
# Perform default perf scheme on a pod
kubectl profiler -n debug highcpupod

# If the previous command didn't work, try forcing perf to use the cpu-clock event
kubectl profiler -n debug highcpupod --extra-arguments "-e cpu-clock"

# Perform bpf scheme on a pod
kubectl profiler -n debug highcpupod -s bpf -o /tmp/flame-bpf.svg

# Perform offcputime profiling on a pod
kubectl profiler mypod -s offcpu -d 60 -o /tmp/flame-offcpu.svg
```
