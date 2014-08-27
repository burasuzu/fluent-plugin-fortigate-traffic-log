# -*- coding: utf-8 -*-
#
require 'time'

  def configure_parser()
    @time_format = '%Y-%m-%d %H:%M:%S'
  end

  def parse_line(line)

    include_space = Array['dst_country','src_country','dstcountry','srccountry']

    # $B%a%b%j%m%0$N>l9g$N8DJL=hM}(B
    if /devname/ !~ line
      # $B%9%Z!<%9$r4^$`MWAG$r0l$D$:$D=hM}(B
      for i in include_space do
        # $B%9%Z!<%9$r4^$`MWAG$,$"$l$P=hM}(B
        if /#{i}/ =~ line
          # $B%9%Z!<%9IU$-$N9qL>$rCj=P(B
          /#{i}="(.*?)"/ =~ line 
          country_name = $1
          # $B9qL>$K6uGr$,4^$^$l$F$$$k$+%A%'%C%/(B
          if /.*\s.*/ =~ country_name
            # $B%9%Z!<%9$,4^$^$l$F$$$k>l9g$O!"%9%Z!<%9:o=|:Q$_$N9qL>$rMQ0U$9$k(B
            new_country_name = country_name.gsub(/\s/,'')
            # $B%9%Z!<%9:o=|:Q$_$N9qL>$G!"85!9$N9qL>$rCV49(B
            line.gsub!("\"#{country_name}\"", "\"#{new_country_name}\"")
          end
        end
      end

      line.gsub!(/\s/,',')
    end

    # $B%m%0$r(B,$B$GJ,3d$7$FG[Ns$K3JG<$9$k(B
    elements = line.split(",")

    # syslog$B8DJL$N=hM}(B
    if /devname/ =~ line
      # syslog$B$N@hF,$HG[Ns$N(B1$BL\$r7k9g(B
      tmp = "#{elements[0]},#{elements[1]}"
      # $B7k9g$7$?$b$N$+$i!"F|;~$rCj=P(B
      tmp =~ /.+date=(.+),time=(.+)/
      tmp_date = $1
      tmp_time = $2

      if /\s/ =~ tmp_time
        # time$B$NCf$K4^$^$l$kH>3Q%9%Z!<%9$r=|5n$9$k!#(B
        tmp_time.gsub!(/(\s)+/,'')
      end

      # $BCj=P$7$?CM$r0l$D$K$^$H$a$F!"(Btime$B%*%V%8%'%/%H7PM3$G(Bunixtime$B$K$9$k(B
      time = "#{tmp_date} #{tmp_time}"
    else
      time = "#{elements[0]} #{elements[1]}"
    end

    time = Time.strptime(time, @time_format).to_i
    # $B=hM}$,=*N;$7$?$N$G!"G[Ns$+$i@hF,(B2$B$D$r:o=|(B
    elements.shift(2)

    record = {}
    while k = elements.shift
      k =~ /(.+)=(.+)/
      record[$1] = $2
    end

    return time, record
  end

# $B%F%9%H(B
  def test
    syslog = ''
    local = ''

    configure_parser()
    time, record = parse_line(local)
    puts time
    puts record
  end

test()
