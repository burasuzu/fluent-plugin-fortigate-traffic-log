class FortgateTrafficLog < Fluent::TailInput
  Fluent::Plugin.register_input('fortigate-traffic-log', self)

  # Override 'configure_parser(conf)' method.
  # You can get config parameters in this method.
  def configure_parser(conf)
    @time_format = conf['time_format'] || '%Y-%m-%d %H:%M:%S'
  end

  # Override 'parse_line(line)' method that returns time and record.
  def parse_line(line)
    # $B%m%0$r(B,$B$GJ,3d$7$FG[Ns$K3JG<$9$k(B
    elements = line.split(",")

    # date$B$H(Btime$B$r7k9g$7$F!"<B:]$NCM$r@55,I=8=$GCj=P$9$k(B
    tmp = "#{elements[0]},#{elements[1]}"
    tmp =~ /.+date=(.+),time=(.+)/
    tmp_date = $1

    # time$B$NCf$K4^$^$l$kH>3Q%9%Z!<%9$r=|5n$9$k!#(B$
    tmp_time = $2.gsub(/(\s)+/,'')

    # $BCj=P$7$?CM$r0l$D$K$^$H$a$F!"(Btime$B%*%V%8%'%/%H7PM3$G(Bunixtime$B$K$9$k(B$
    time = "#{tmp_date} #{tmp_time}"
    time = Time.strptime(time, @time_format).to_i

    # $B=hM}$,=*N;$7$?$N$G!"G[Ns$+$i@hF,(B2$B$D$r:o=|(B$
    elements.shift(2)

    # $B%H%i%U%#%C%/%m%0$N=hM}(B
    record = {}
    while k = elements.shift
      k =~ /(.+)=(.+)/
      record[$1] = $2
    end

    return time, record
  end
end
