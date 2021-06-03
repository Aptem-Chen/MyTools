fn getVertsPos obj = (
	vertsStr = ""
	
	for i = 1 to obj.numverts do (
		vert = getVert obj i
		x = vert[1]
		y = vert[2]
		z = vert[3]
		
		xStr = "\"x\":" + x as string
		yStr = "\"y\":" + y as string
		zStr = "\"z\":" + z as string
		
		posStr = "{" + xStr + "," + yStr + "," + zStr + "},"
		vertsStr += posStr
	)
	
	vertsStr
)

fn getFaceInfo obj = (
	centerXStr = "\"x\":" + obj.center[1] as string
	centerYStr = "\"y\":" + obj.center[2] as string
	centerZStr = "\"z\":" + obj.center[3] as string
	centerStr = "{" + centerXStr + "," + centerYStr + "," + centerZStr + "}"
	
	min2 = Point2 obj.min[1] obj.min[2]
	max2 = Point2 obj.max[1] obj.max[2]
	widthStr = (distance min2 max2) as string
	heightStr = (obj.max[3] - obj.min[3]) as string
	sizeStr = "{\"x\":" + widthStr +  ",\"y\":" + heightStr + "}"
	
	fNormal = getFaceNormal obj 1
	fNormalXStr = fNormal[1] as string
	fNormalYStr = fNormal[2] as string
	fNormalZStr = fNormal[3] as string
	fNormalStr = "{\"x\":" + fNormalXStr + ",\"y\":" + fNormalYStr + ",\"z\":" + fNormalZStr + "}"
	
	#(centerStr, sizeStr, fNormalStr)
)

fn main = (
	currentMesh = $

	if currentMesh == undefined or not isKindOf currentMesh Editable_Mesh then () else (
		print(getVertsPos currentMesh)
		print(getFaceInfo currentMesh)
	)
)

main()
