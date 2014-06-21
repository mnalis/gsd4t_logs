created on Samsung Galaxy S2, running CyanogenMod9, but setting DEBUGGING_FILES=1 in /system/etc/sirfgps.conf
debug files were created in /data

also created strace.log.* by using (after booting and starting GPS app):

# lsof | grep /dev/ttySAC1	# determine PID of system_server (2029) and FD of GPS device (275)
system_se  2029     system  275       ???                ???       ???        ??? /dev/ttySAC1

# strace -e trace=open,read,write -e write=275 -e read=275 -tt -v -ff -o strace.log  -p 2029


system rebooted around 11:56:15 CEST, GPS app started around 12:00:00, FIX
around 12:00:16 CEST (satstat GPS app says TTFF 13 secs). 
strace started around 12:02:02 CEST.
app exited about 12:03:00 CEST.
logs finished about 12:04:45 CEST.

FIXMEs:
- should've done "lsof 2029 > fd.2029.txt" before strace
- "strace -s4096" so we see the log messages too
- "strace -e write=275" does not seem to log HEX dump for writes, why?  read=275 works ok...
