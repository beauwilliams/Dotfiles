# Step 1

Add custom name servers provided by clourflare

*Note there should be 2 such as archer.ns.cloudflare.com

Switch to the settings

# Step 2

Set up DNSSEC

Head to DNS tab in cloudflare

Copy digest, algorithm, key tag

# Step 3

Set up 2 domains in heroku,

1, www.example.com
2, example.com

# Step 4

Under DNS tab, DNS Management

Upload the CNAME records from step 3 to cloudflare

Use @ for root - i.e example.com
Change type to CNAME
past in the tapered-pigweed-mziuswhzj288kqm7vp15v6lp.herokudns.com type link given in step 3 into target
leave proxy status on

for www.example.com we use www for the 'Name'
and then the second crystalline-marmot-c09m6e9vwvpv2j1caug34d1l.herokudns.com type link when making the www.example.com one in heroku

....that should be it!

