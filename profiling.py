#!/usr/bin/python

from netfilterqueue import NetfilterQueue
from scapy.all import *
import line_profiler
profile = line_profiler.LineProfiler()
runId = sys.argv[3]
atexit.register(profile.dump_stats, f"mer{runId}.lprof")


@profile
def main():

    pktCount = 0

    @profile
    def process(pkt):
        global pktCount
        scapyPkt = IP(pkt.get_payload())

        if scapyPkt.haslayer('ICMP') and scapyPkt.haslayer('Raw'):
            icmpData = list(scapyPkt[Raw].load)
            inputMessage = sys.argv[2]
            message = inputMessage[:48]

            icmpData[8:8 + len(message)] = [ord(i) for i in message]
            scapyPkt[Raw].remove_payload()
            scapyPkt[Raw].load = bytes(icmpData)
            del scapyPkt[IP].len
            del scapyPkt[ICMP].chksum

        pkt.set_payload(bytes(scapyPkt))
        pkt.accept()

        pktCount += 1
        if pktCount >= 100:
            nfqueue.stop()

    os.system('sudo iptables -A OUTPUT -d ' + sys.argv[1] + ' -p icmp -j NFQUEUE --queue-num 1')
    nfqueue = NetfilterQueue()
    nfqueue.bind(1, process)

    try:
        nfqueue.run()
    finally:
        os.system('sudo iptables -D OUTPUT -d ' + sys.argv[1] + ' -p icmp -j NFQUEUE --queue-num 1')
        nfqueue.unbind()
        return


if __name__ == '__main__':
    for i in range(100):
        main()
