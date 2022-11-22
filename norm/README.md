# norm-trafficgenerator
This http traffic generator uses a truncated discrete normal distribution to limit the connection per second (CPS) stablished with the webserver. 

``In statistics, a truncated distribution is a conditional distribution that results from restricting the domain of some other probability distribution. (https://en.wikipedia.org/wiki/Truncated_distribution)``


This could be used to setup correctly a token bucket  algorithm on your packet shaper,
 to generate "normal" traffic on your website instead a plain distribution traffic.

Feel free to modify it for your purposes, it's a PoC to play with threading in Python, so I know that It could be better.  


## How it works:
 - First of all, N threads are spawned _num_cores * 2_  in order to be able to handle large number of requests
 - A truncated normal distribution is generated with total length of N samples (max_execution_time)
 - Every second,  the CPS permitted  are changed following the samples generated in the step before.   

To test your website you'll need to set up the script as follows:

```
url: "http://127.0.0.1/sample.txt"
max_execution_time: 10
normal_distribution: { mean: 10, standard_deviation: 2, upper_limit: 14, lower_limit: 8}
```

max_execution_time is measured in. 

If you take a look into you apache/nginx log you will be able to see, something like that a normal distribution centered in 10:
```
 11 [09/Sep/2018:20:38:34
 10 [09/Sep/2018:20:38:35
  8 [09/Sep/2018:20:38:36
  9 [09/Sep/2018:20:38:54
 10 [09/Sep/2018:20:38:55
 11 [09/Sep/2018:20:38:56
 10 [09/Sep/2018:20:38:57
 10 [09/Sep/2018:20:38:58
 10 [09/Sep/2018:20:38:59
 10 [09/Sep/2018:20:39:00
 10 [09/Sep/2018:20:39:01
 11 [09/Sep/2018:20:39:02
 11 [09/Sep/2018:20:39:03
  8 [09/Sep/2018:20:39:04
```