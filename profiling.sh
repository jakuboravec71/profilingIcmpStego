#!/usr/bin/sh

DESTIP="192.168.0.13"
SCRIPT="profiling.py"

touch profiling.txt
echo "Running script: $SCRIPT, IP: $DESTIP"
ping -c 2 $DESTIP > /dev/null
date

ping -i 0.2 $DESTIP > /dev/null &
PING_PID=$!

[ -f meas1.lprof ] && sudo rm meas1.lprof;
[ -f meas2.lprof ] && sudo rm meas2.lprof;
[ -f meas3.lprof ] && sudo rm meas3.lprof;
[ -f meas4.lprof ] && sudo rm meas4.lprof;
[ -f meas5.lprof ] && sudo rm meas5.lprof;
[ -f meas6.lprof ] && sudo rm meas6.lprof;
[ -f meas7.lprof ] && sudo rm meas7.lprof;
[ -f meas8.lprof ] && sudo rm meas8.lprof;
[ -f meas9.lprof ] && sudo rm meas9.lprof;
[ -f meas10.lprof ] && sudo rm meas10.lprof;

echo "100 hits:" >> profiling.txt
printf "\n" >> profiling.txt

sudo kernprof -l -v -o meas1.lprof $SCRIPT $DESTIP 'Universal Declaration of Human Rights Preamble W' 1 > /dev/null 2>&1
sudo kernprof -l -v -o meas2.lprof $SCRIPT $DESTIP 'hereas recognition of the inherent dignity and o' 2 > /dev/null 2>&1
sudo kernprof -l -v -o meas3.lprof $SCRIPT $DESTIP 'f the equal and inalienable rights of all member' 3 > /dev/null 2>&1
sudo kernprof -l -v -o meas4.lprof $SCRIPT $DESTIP 's of the human family is the foundation of freed' 4 > /dev/null 2>&1
sudo kernprof -l -v -o meas5.lprof $SCRIPT $DESTIP 'om, justice and peace in the world, Whereas disr' 5 > /dev/null 2>&1
sudo kernprof -l -v -o meas6.lprof $SCRIPT $DESTIP 'egard and contempt for human rights have resulte' 6 > /dev/null 2>&1
sudo kernprof -l -v -o meas7.lprof $SCRIPT $DESTIP 'd in barbarous acts which have outraged the cons' 7 > /dev/null 2>&1
sudo kernprof -l -v -o meas8.lprof $SCRIPT $DESTIP 'cience of mankind, and the advent of a world in ' 8 > /dev/null 2>&1
sudo kernprof -l -v -o meas9.lprof $SCRIPT $DESTIP 'which human beings shall enjoy freedom of speech' 9 > /dev/null 2>&1
sudo kernprof -l -v -o meas10.lprof $SCRIPT $DESTIP ' and belief and freedom from fear and want has b' 10 > /dev/null 2>&1

python3 -m line_profiler meas1.lprof >> profiling.txt;
printf "\n\n" >> profiling.txt
python3 -m line_profiler meas2.lprof >> profiling.txt;
printf "\n\n" >> profiling.txt
python3 -m line_profiler meas3.lprof >> profiling.txt;
printf "\n\n" >> profiling.txt
python3 -m line_profiler meas4.lprof >> profiling.txt;
printf "\n\n" >> profiling.txt
python3 -m line_profiler meas5.lprof >> profiling.txt;
printf "\n\n" >> profiling.txt
python3 -m line_profiler meas6.lprof >> profiling.txt;
printf "\n\n" >> profiling.txt
python3 -m line_profiler meas7.lprof >> profiling.txt;
printf "\n\n" >> profiling.txt
python3 -m line_profiler meas8.lprof >> profiling.txt;
printf "\n\n" >> profiling.txt
python3 -m line_profiler meas9.lprof >> profiling.txt;
printf "\n\n" >> profiling.txt
python3 -m line_profiler meas10.lprof >> profiling.txt;
printf "\n\n" >> profiling.txt

kill $PING_PID 2>/dev/null
echo "DONE!"
date
