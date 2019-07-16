# DNS-Zone-Xfer
Simple bash tool that finds DNS servers given a target address and attempts a zone transfer on all servers found.

Usage:   ~: ./DNS-Zone-Xfer <target> [-o output-file]
  
Examples:

~: ./DNS-Zone-Xfer google.com -o domains-found.txt

~: ./DNS-Zone-Xfer microsoft.com -o /tmp/domains.txt

~: ./DNS-Zone-Xfer yahoo.com
