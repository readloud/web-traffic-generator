from loguru import logger
import numpy
from math import sin, cos, sqrt, atan2, radians, degrees

# approximate radius of earth in km
R = 6373.0


def calculateTrajectory(flight):

    startPort = flight["startPort"]
    endPort = flight["endPort"]
    cruiseSpeed = flight["cruiseSpeed"]

    trajectory = []

    distanceKm = calculateDistance(startPort, endPort)

    timeS = (distanceKm / cruiseSpeed) * 60 * 60
    logger.info("Calculated timeS - {}", timeS)

    timeTaken = int(timeS)

    latTrajectory = calculateTrajectoryPoints(
        startPort, endPort, "latDeg", timeTaken)
    lonTrajectory = calculateTrajectoryPoints(
        startPort, endPort, "lonDeg", timeTaken)

    pointA = [startPort['latDeg'], startPort['lonDeg']]
    pointB = [endPort['latDeg'], endPort['lonDeg']]
    heading = (calculateHeading(pointA, pointB))

    for x in range(len(latTrajectory)):

        latDeg = latTrajectory[x]
        lonDeg = lonTrajectory[x]

        trajectory.append({
            'latDeg': latDeg,
            'lonDeg': lonDeg,
            'trueHeading': heading
        })

    return trajectory


def calculateTrajectoryPoints(startPort, endPort, coType, timeTaken):

    trajectoryPts = []

    pointA = None
    pointB = None

    reversePts = False

    if startPort[coType] < endPort[coType]:
        pointA = startPort[coType]
        pointB = endPort[coType]

    else:
        pointB = startPort[coType]
        pointA = endPort[coType]

        reversePts = True

    for rPoint in numpy.linspace(pointA, pointB, timeTaken):

        trajectoryPts.append(rPoint)

    if reversePts:

        trajectoryPts.reverse()

    return trajectoryPts


def calculateDistance(startPort, endPort):

    lat1 = radians(startPort["latDeg"])
    lon1 = radians(startPort["lonDeg"])

    lat2 = radians(endPort["latDeg"])
    lon2 = radians(endPort["lonDeg"])

    dlon = lon2 - lon1
    dlat = lat2 - lat1

    a = sin(dlat / 2)**2 + cos(lat1) * cos(lat2) * sin(dlon / 2)**2
    c = 2 * atan2(sqrt(a), sqrt(1 - a))

    distance = R * c     # In km

    return distance


def calculateHeading(pointA, pointB):

    lat1 = radians(pointA[0])
    lat2 = radians(pointB[0])

    diffLong = radians(pointB[1] - pointA[1])

    x = sin(diffLong) * cos(lat2)
    y = cos(lat1) * sin(lat2) - (sin(lat1)
                                 * cos(lat2) * cos(diffLong))

    initial_bearing = atan2(x, y)

    initial_bearing = degrees(initial_bearing)
    compass_bearing = (initial_bearing + 360) % 360

    return compass_bearing
