# IP Geolocation API

Have you ever had the requirement to know from which geographical locations certain IPs flow into your website/service? I thought so...

This is why I built the Geolocation API that transforms IPv4 addresses into country and city information where the location is known.

The project is based on a free database provided by IP2Location (https://lite.ip2location.com/ip2location-lite).

---

### Standalone

The project works completely standalone without any external services. That makes it easy to deploy and operate.

### Super Fast

The API is optimized for speed right from the beginning. It is written in Crystal and holds all of its required data in memory (like the mappings from IPs to locations).
Single requests can easily be handled at sub-millisecond response times.

Using a local benchmark on my local machine using wrk2 (`wrk2 -t2 -c10 -d60 -R5000 "http://localhost:8080/v1/locate?q=233.234.235.236"`) the API was able to provide a throughput of 2.53k requests/second at an average latency of ~11ms.
