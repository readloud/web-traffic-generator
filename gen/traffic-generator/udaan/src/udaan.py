from loguru import logger
import json
import socketio
import datetime
import time
import numpy
import threading
import random

import trajectory as trajectoryUtil
from util import airports as airportsUtil


sio = socketio.Client()


@sio.event
def connect():
    logger.info("Connected to Server")


def main():

    logger.info("Namaskar Mandali!")

    if True:

        sio.connect('http://localhost:8786')

        trajectories = []

        flights = getBayAreaFlights()

        # flights = getRandomFlights(10)

        for flight in flights:
            trajectory = trajectoryUtil.calculateTrajectory(flight)
            trajectories.append(trajectory)

        flightThreads = []

        for x in range(len(flights)):

            flight = flights[x]
            trajectory = trajectories[x]

            flightThread = threading.Thread(
                target=flyFlight, args=(flight, trajectory,))

            flightThread.start()

            flightThreads.append(flightThread)

        for flightThread in flightThreads:
            flightThread.join()


def getBayAreaFlights():

    SFO = airportsUtil.getAirport("SFO")
    SJC = airportsUtil.getAirport("SJC")

    flights = [
        {
            'callsign': "ARKITS1",
            'startPort': SFO,
            'endPort': SJC,
            'cruiseSpeed': 222
        },
        {
            'callsign': "ARKITS2",
            'startPort': SJC,
            'endPort': SFO,
            'cruiseSpeed': 564
        }
    ]

    return flights


def getRandomFlights(numberOfFlights):

    speeds = [222, 564]

    flights = []

    for x in range(numberOfFlights):

        airportA = airportsUtil.getRandomUsAirport()
        airportB = airportsUtil.getRandomUsAirport()

        flight = {
            "callsign": "ARKITS" + str(x),
            "startPort": airportA,
            "endPort": airportB,
            'cruiseSpeed': random.choice(speeds)
        }

        flights.append(flight)

    return flights


def flyFlight(flight, trajectory):

    for trajectoryPoint in trajectory:

        flyVehicle(flight, trajectoryPoint)

        time.sleep(1)


def flyVehicle(flight, trajectoryPoint):

    payload = {
        'data': {
            'vid': flight['callsign'],
            'latDeg': trajectoryPoint['latDeg'],
            'lonDeg': trajectoryPoint['lonDeg'],
            'altFt': 2000,
            'trueHeading' : trajectoryPoint['trueHeading']
        },
        'metadata': {
            'sourceTimestamp': str(datetime.datetime.utcnow().isoformat())
        }
    }

    logger.info("Emitting - {}", payload)

    sio.emit('brodcast_position', payload)


if __name__ == '__main__':
    main()
