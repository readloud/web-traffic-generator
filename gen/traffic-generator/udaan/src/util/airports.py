import json
from loguru import logger
import random

airportsFile = None


def readAirportsFile():

    with open('resources/airport-codes_json.json') as f:

        logger.debug("Reading aiports file...")

        global airportsFile

        airportsFile = json.load(f)

        logger.debug("We Got - {} airports!", len(airportsFile))


def getAirport(airportCode):

    airportToReturn = None

    for element in airportsFile:

        if element['iata_code'] == airportCode:

            airportToReturn = element

            break

    return convertToUdaanAirport(airportToReturn)


def getRandomAirport():

    return convertToUdaanAirport(random.choice(airportsFile))


def getRandomUsAirport():

    keepLooping = True

    while keepLooping:

        airport = random.choice(airportsFile)

        if airport["iso_country"] == "US":

            keepLooping = False

    return convertToUdaanAirport(airport)


def convertToUdaanAirport(airport):

    coords = airport["coordinates"].split(",")

    udaanAirport = {
        "iata_code": airport["iata_code"],
        "latDeg": float(coords[1]),
        "lonDeg": float(coords[0]),
        "name": airport["name"]
    }

    return udaanAirport


# Read the airports file once on start-up
readAirportsFile()
