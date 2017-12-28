# DNSTrack

[![security](https://hakiri.io/github/Janfred/dnstrack/master.svg)](https://hakiri.io/github/Janfred/dnstrack/master)
[![Dependency Status](https://gemnasium.com/badges/github.com/Janfred/dnstrack.svg)](https://gemnasium.com/github.com/Janfred/dnstrack)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/b400eb73c7dd4313b680b7379a91f045)](https://www.codacy.com/app/Janfred/dnstrack?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=Janfred/dnstrack&amp;utm_campaign=Badge_Grade)
[![Codacy Badge](https://api.codacy.com/project/badge/Coverage/b400eb73c7dd4313b680b7379a91f045)](https://www.codacy.com/app/Janfred/dnstrack?utm_source=github.com&utm_medium=referral&utm_content=Janfred/dnstrack&utm_campaign=Badge_Coverage)
[![Build Status](https://travis-ci.org/Janfred/dnstrack.svg?branch=master)](https://travis-ci.org/Janfred/dnstrack)

This webapp is currently in development status. After the Development it should
cover the following features:

* Managing DNS Zones for at least PowerDNS (Database backend)
  * If possible also nsupdate backend
  * Maybe rake task for generating bind zone configs
* DNS-Features
  * Forward zone entries with all usual DNS RR Types (e.g. `A`, `AAAA`, `SRV`,
    `MX`, ...)
  * Reverse zone support (`PTR`)
  * Generation of Reverse Zone from Forward zones
* User management for different access
  * Give access to whole zone, subdomain, one specific record (useful for
    Reverse records)
  * Restrict Resource Reccords (white- and blacklisting)
