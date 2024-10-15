# web-traffic-generator

A basic Python script generates traffic (GET) against a given web site.

---

A basic Python script that takes command line entry to run against a web site. Taking all available links on the target site and randomly doing gets against each. This is to generate traffic against the target only. Results of connecting are logged as STDOUT only and not to file. Setting log levels is supported to limit output if required, default is INFO.

## Usage

This example script is to be used a test site to generate web traffic against a specific web site to provide data in other tools for example creating flow traffic in Nexus Dashboard Insights.

Two methods are available to use the script:

1. Locally from a laptop with python 3.10 installed and using virtual environments.
2. Using the provided Dockerfile to create a local image and run as a container.

## Installation

To begin clone the repository to you local working directory.

```bash
git clone https://github.com/CiscoSE/web-traffic-generator.git
```

Once cloned change to the new project directory `cd web-traffic-generator` choose one of the following to run.

* [Run locally](#run-locally-with-python-virtual-envirnonment)
* [Run using Docker](#run-using-docker)

### Run Locally with Python Virtual Envirnonment

<!-- TODO Create instructions for running from local OS from VENV -->

If running locally start by creating and activating a python virtual environment.

```bash
python3 -m venv venv
source venv/bin/activate
```

Next use pip to install the required python libraries.

```bash
pip install -f requirements.txt
```

Finally, run the python scipt using cli arguments to set the target URL and optional flags.

```bash
python3 main.py <URL>
```

#### Available Command Line Option Flags

| Option Flag | Default | Description |
| --- | --- | --- |
| --sleep | 5 | Set the time between request against found links |
| --log, -l | INFO | Sets the logging level for output |

#### Example

The following are examples of executing the different options against a target URL.

* Running script against <https://cisco.com> with default flags

```bash
python3 main.py https://cisco.com
```

* Running script with DEBUG logging against <https://cisco.com>

```bash
python3 main.py -l DEBUG https://cisco.com
```

* Running script against <https://cisco.com> with 10 seconds between requests (sleep timer)

```bash
python3 main.py --sleep 10 https://cisco.com
```

* Running script against <https://cisco.com> with 10 seconds between requests (sleep timer) with logging set to DEBUG

```bash
python3 main.py --sleep 10 -l DEBUG https://cisco.com
```

### Run using Docker

A Dockerfile is included to quickly build a docker contaitner and start generating GET request against a target URLs contained links. It is assumed that Docker is already installed please refer to offical Docker installation documentation for help on setting up Docker locally.

1. To start clone the repository locally.
2. Build a docker image using the Dockerfile

```bash
docker build -t <image name> .
```

3. Create and run Docker container updating environment variables as required to set target URL. By default target URL is set to `https://google.ca`.

```bash
docker run -it --rm -e URL="https://cisco.com" web-traffic-generator
```

#### Available Environment Variable

| Environment Variable | Default |
| --- | --- |
| URL | <https://google.ca> |
| SLEEP | 5 |
| LOG | INFO |

#### Example Docker Run Commands

* Running script with DEBUG logging against <https://cisco.com>

```bash
docker run -it --rm -e URL="https://cisco.com" -e LOG="DEBUG" web-traffic-generator
```

* Running script against <https://cisco.com> with 10 seconds between requests (sleep timer)

```bash
docker run -it --rm -e URL="https://cisco.com" -e SLEEP="10" web-traffic-generator
```

* Running script against <https://cisco.com> with 10 seconds between requests (sleep timer) with logging set to DEBUG

```bash
docker run -it --rm -e URL="https://cisco.com" -e SLEEP="10" -e LOG="DEBUG" web-traffic-generator
```

<!-- ## Documentation

Pointer to reference documentation for this project. -->
