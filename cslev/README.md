# Webtraffic Generator 
This repository can generate **(encrypted) WEB (TCP+TLC, QUIC)** and **DNS (DoH) traffic** in an isolated environment for 
encrypted **webtraffic analysis**.

# What it does
 - A webbrowser (Firefox) is started within a Docker container and instructed to visit the most popular web sites
 - Firefox can be configured to use different encrypted protocols, e.g., QUIC, TCP, encrypted DNS (DNS-over-HTTPS)
 - For DoH, one can configure several different DoH resolver to use
 - The encrypted traffic (along with the SSL keys to decrypt it) is captured within the container (only the relevant packets: HTTP1/2/3,DNS,UDP,TLS,QUIC,DoH, but no pure TCP, e.g, no TCP SYN,SYN/ACK,ACK)
 - The container provides adequate traffic isolation, i.e., no background noise/traffic is captured from your host
 - TCP Segmentation Offload can be disabled (if your host also supports), thereby you will have MTU sized packets only in the trace (just like an intermediate node/attacker would see your traffic when eavesdropping)
 - Docker makes is easy to run several instances in parallel to generate the desired amount of traffic as soon as possible
 - the PCAP files are only temporarily stored (due to their size) and decrypted straightaway (using the SSL keys) to preprocess them, and make a lightweight CSV representation instead
 - at the end, you will have the decrypted traffic as CSV file including all necessary packet header and payload data that you can fed into a Machine learning/Deep learning application 

## Relevant application and base docker version information
 - debian:bullseye
 - python3
 - python3-selenium for firefox scripting
 - Firefox 109.0
 - geckodriver v32

# Requirements
Being a docker container, you have to have a running docker subsystem installed. If you have no such subsystem, first, go to [https://docs.docker.com/install/linux/docker-ce/debian/](https://docs.docker.com/install/linux/docker-ce/debian/), pick your distribution on the left hand side, and follow the instructions to install it.

It is also recommended to have `docker-compose` as it makes running the container much easier and transparent, not to mention the capability to run and manage multiple containers at once.


# Obtaining the container
Since dockerHub does no longer support automated builds for free users, you might build your image from scratch from the source to have an up-to-date version.
There might be an image up @dockerHub, but use it with cautions

## <a name="build"></a> Build your own image
### AMD64 / Intel x86_64
Clone the repository first, then build the image.
```
git clone https://github.com/cslev/webtraffic_generator
cd webtraffic_generator
sudo docker build -t cslev/webtraffic_generator:latest -f Dockerfile  .
```
In the last command `-t` specifies the tag (default `latest`) used for our image! Feel free to use another tag, but to be sync with a possible future update might be coming from


## Requirements

# Start container
## docker-compose
This is the easiest way to launch as the provided docker-compose.yml also shows you all details/variables you can set.
```
version: '3.6'

services:
  quic1:
    image: 'cslev/webtraffic_generator:latest'
    container_name: No_DoH  #rename according to you scenario for easier identification

    volumes:
      - './container_data/WEBTRAFFIC_GEN/archives:/webtraffic_gen_project/archives:rw'
      #for PCAP files - default they are deleted due to storage concerns - set it below to keep them
      - './container_data/WEBTRAFFIC_GEN/pcap:/webtraffic_gen_project/pcap:rw'
      #for any additional domain lists, please add yours into ./source/domain_lists and refer to it via webtraffic_generator_DOMAIN_LIST later
      - './source/domain_lists:/webtraffic_gen_project/domain_lists:ro'
    dns: 1.1.1.1 #Remove this line if third-party DNS is not allowed
    shm_size: '4g'

    environment:
      WEBTRAFFIC_GENERATOR_NAME: 'webtraffic_generator'  #should be same as container_name
      WEBTRAFFIC_GENERATOR_RESOLVER: ${R1} # resolver to use (defined in .env file)
      WEBTRAFFIC_GENERATOR_START: '1' #first domain to visit in the domain list
      WEBTRAFFIC_GENERATOR_END: '5000' #last domain to visit in the domain list
      WEBTRAFFIC_GENERATOR_BATCH: '200' #how many domains to visit within a batch (don't change unless you know what you are doing)
      WEBTRAFFIC_GENERATOR_INTF: 'eth0' #change this if your container would not have eth0 as a default interface
      WEBTRAFFIC_GENERATOR_DOMAIN_LIST: '/webtraffic_gen_project/domain_lists/top-1m_tranco2021.csv' #the relative path inside the container pointing to the list of domains to visit (in Alexa list style: id, domain <-one each line)
      WEBTRAFFIC_GENERATOR_META: 'sg_quic_no_doh' #any meta info to affix your final output files for easier identification
      WEBTRAFFIC_GENERATOR_WEBPAGE_TIMEOUT: '20' #how many seconds we wait for a website to load before throwing timeout error and skip
      WEBTRAFFIC_GENERATOR_ARCHIVE_PATH: '/webtraffic_gen_project/archives' #where to store the compressed output. Should be the same as defined by the 'volume'
      WEBTRAFFIC_GENERATOR_USE_QUIC: '1' #set it to 1 to enable Quic or 0 to disable
      WEBTRAFFIC_GENERATOR_KEEP_PCAP: '0' #DEBUG ONLY: pcap files can consume all your free space, Set it to 1 to keep pcap and 0 otherwise
      WEBTRAFFIC_GENERATOR_TSO_ON: '0' #Disabled by default as we don't want the NIC to buffer and concatenate fragmented packets that result in jumbo frames. We want packets not greater than 1500B

```
One thing to note here is the variable `${R1}`. 
This is just to ease automation, you can freely use any of the DoH resolvers defined in the [r_config.json](https://github.com/cslev/webtraffic_generator/blob/main/source/r_config.json).

On the other hand, you can define variables in the `.env` (located in the same directory as your docker-compose yaml file), and use them in the yaml file.

The example above does the following:
 - visits the first 5000 domains in the Alexa's top 1M domains (provided by the `top-1m.csv` file in the source. 
 - Batch size of visiting and processing the data is set to 200 (it has been checked before several times about what the optimal number for batch size is, and 200 is the most efficient. Hence, it is not recommended to change this to a higher value; lower is fine :)
 - Firefox is enforced to try to use QUIC if possible
 - PCAP files will be deleted and only the analyzed .csv version of them will be kept. The .csv files are the same as the pcap with better resource usage and unnecessary information removed. You can keep the pcap files if needed, but bear in mind your data storage!
 - All data will be stored in the directories defined via the `volumes` tags
 - plain-text DNS server of the container is set to 1.1.1.1 for easier filtering

### Run via docker-compose
Issue the following command in the same directory, where your `docker-compose.yml` file is at.

```
$ sudo docker-compose up -d
```
Note, omit `-d` if you want to see the output.

### Process data
All data is found under the directory defined in the `volumes` tag.
Unzip the archive (and check the pcap with the SSL key if requested to store it), and process data.

## Generate docker-compose.yml
If you want a quick test, use the `docker_compose_gen` script to generate a yaml file. This script is handy when you want to run mulitple instances of the same container.
```
$ cd docker_compose_gen/
$ ./docker_compose_gen.sh -h
This script generates a docker-compose.yml file by adding the number of required services to one file. You want to run 20 container, then this script generates your the yaml file ...!
Usage: ./docker_compose_gen.sh -n <NUM> -a <ARCH> -m <META>
                -n <NUM>: set the number of required docker containers (Default: 10).
                -a <ARCH>: set the architecture the container will run on top. 'latest' is generic x86_64, while 'aarch64' is for ARM 64-bit (Default: latest).
                -m <META>: set the metadata for the container (Default: cloudlabs_utah_intel64).
```
Let's make a simple two-container setup called `test` using general purpose architecture (e.g., docker tag is `latest`)

```
$ ./docker_compose_gen.sh -n 2 -m test -a latest
Preparing base skeleton...[DONE]
Generating the rest of the yaml file...[DONE]
```
Your file is now ready to use. Let's move it one folder backward.
```
mv docker-compose_2.yml ../
```
Use `docker-compose -f docker-compose_2.yml up -d` to launch your two containers in the background.

## Run via the traditional Docker way
Define and pass all variables to the `docker run` command as it requires. Follow, the environment variables defined in the `docker-compose.yml` above.
For instance,
```
sudo docker run -d --name webtraffic_generator \
  -e WEBTRAFFIC_GENERATOR_NAME='my_doh' 
  -e WEBTRAFFIC_GENERATOR_RESOLVER='DISABLED' \
  -e WEBTRAFFIC_GENERATOR_START='1' \
  -e WEBTRAFFIC_GENERATOR_END='1000' \
  -e WEBTRAFFIC_GENERATOR_BATCH='200' \
  -e WEBTRAFFIC_GENERATOR_INTF:'eth0' \
  -e WEBTRAFFIC_GENERATOR_DOMAIN_LIST:'/webtraffic_gen_project/domain_lists/top-1m_tranco2021.csv' \
  -e WEBTRAFFIC_GENERATOR_META:'sg_quic_no_doh' \
  -e WEBTRAFFIC_GENERATOR_WEBPAGE_TIMEOUT: '20' \
  -e WEBTRAFFIC_GENERATOR_ARCHIVE_PATH: '/webtraffic_gen_project/archives' \
  -e WEBTRAFFIC_GENERATOR_USE_QUIC:'1' \
  -e WEBTRAFFIC_GENERATOR_KEEP_PCAP:'0' \
  -e WEBTRAFFIC_GENERATOR_TSO_ON:'0' \
  -v ./container_data/WEBTRAFFIC_GEN/archives:/webtraffic_gen_project/archives:rw \
  -v './container_data/WEBTRAFFIC_GEN/pcap:/webtraffic_gen_project/pcap:rw'
  -v ./source/domain_lists:/webtraffic_gen_project/domain_lists \
  --shm-size 4g cslev/doh_docker:latest
```

