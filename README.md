# Fluent::Plugin::Fortigate::Traffic::Log

FortiGate$B$+$i<u?.$7$?(Bsyslog$B$r%Q!<%9$9$k!"(BFluent$B$N(BTail$B%$%s%W%C%H%W%i%0%$%s%Q!<%5!<$G$9!#(B
$B"((BOS4.0 MR3 Patch 14$B$GF0:n3NG'$r9T$C$F$$$^$9!#(B

## Installation

1. FortiGate$B$K(Bsyslog$B$N@_Dj$r$7$F$/$@$5$$!#(B(CSV$B%U%)!<%^%C%H$rM-8z$K$7$F$/$@$5$$(B)
2. in_fortigate_traffic_log.rb$B$r(B/etc/fluent/plugin$BG[2<$K@_CV$7$F$/$@$5$$(B

## Fluent's Configuration

    <source>
       type fortigate-traffic-log
       path /path/to/your/logfile
       pos_file /path/to/your/posfile
       tag yourtag
       time_format %Y-%m-%d %H:%M:%S
    </source>

