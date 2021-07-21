
import math

def getSpirographCoordinates():
	# Tommy Trojan Coordinates
	origin = {"lat": 34.021266, "lng": -118.289224}

	# An array to hold the coordinates of the spirograph
	paths = []; 

	# Parameters for the spirograph
	R = 8
	r = 1
	a = 4
	x0 = R + r - a 
	y0 = 0

	cos = math.cos 
	sin = math.sin 
	pi = math.pi
	n = 16 

	# Parameter to scale the spirograph
	spiroScale = 0.001; 

	# Loop and generate coordinates
	t = 0.0
	while t < (pi * n):
		x = (R + r) * cos((r / R) * t) - a * cos((1 + r / R) * t) 
		y = (R + r) * sin((r / R) * t) - a * sin((1 + r / R) * t)
		t += 0.001

		x *= spiroScale 
		y *= spiroScale

		paths.append({"lat": origin["lat"] + x, "lng": origin["lng"] + y})

	#print (paths)
	return paths

#To automate the kml file from the output
f = open("spiro.kml", "w")
f.write('<?xml version="1.0" encoding="UTF-8"?><kml xmlns="http://earth.google.com/kml/2.0"><Document>')
count = 0
for i in getSpirographCoordinates():
	count = count+1
	f.write('<Placemark><Point><coordinates>'+str(i["lng"])+','+str(i["lat"])+'</coordinates></Point></Placemark>')
print (count)
f.write('</Document>  </kml>')
f.close()