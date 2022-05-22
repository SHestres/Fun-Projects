minRes = 40
xOffset = 0
yOffset = 0
zoom = 1
def setup():
    #size(400, 400)
    fullScreen()
    noLoop()
    background(0)
    noStroke()
    
    #Convenience
    global centerX
    centerX = width / 2
    global centerY
    centerY = height / 2
    colorMode(HSB)
    
    #Limits how detailed the image will render, for use when automatically increasing resolution
    global maxRes
    maxRes = 1000
    if(maxRes > width):
        maxRes = width
    
    #The resolution of the rendered mandelbrot set
    global reso
    reso = minRes
    
    loadPixels()
    redraw()

def draw():
    global xOffset
    global yOffset
    global zoom
    global reso
    #if(reso < maxRes):
        #reso *= 2
    
    #Iterate through every pixel that gets color evaluated. Call drawPix to color all related pixels
    for i in [pix * width / reso for pix in range(reso)]:
        for j in [pix * height / reso for pix in range(reso)]:
            drawPix(i, j, reso, xOffset, yOffset)
    
    updatePixels()

    

def keyPressed():
    global xOffset
    global yOffset
    global zoom
    global reso
    
    if key == "a":
        xOffset -= .1 * zoom
    if key == "d":
        xOffset += .1 * zoom
    if key == "w":
        yOffset -= .1 * zoom
    if key == "s":
        yOffset += .1 * zoom

    if keyCode == UP:
        zoom *= 1.1
    if keyCode == DOWN:
        zoom *= 0.9
        
    if keyCode == RIGHT:
        reso *= 2
    if keyCode == LEFT:
        reso /= 2
        
    redraw()
            
#Iterates over all pixels assigning a color based on how quickly a given value diverges using the sqPlus function
#Colors a full block the same color given a reference pixel and how big a given pixel block should be (via the resolution)
#xOffset, yOffset, and zoom allow the user to explore the scene
def drawPix(i, j, res, xOff, yOff):
    global zoom
    
    #Determine Reference complex number
    xVal = float(i - centerX) * 3 / width
    yVal = float(j - centerY) * 3/ width 
    c = complex(xVal * zoom + xOff, yVal * zoom + yOff)
    
    #Determine the reference color based on the speed of divergence of that number
    col = color(0, 0, 0)
    iters = sqPlus(c)
    if (iters) > 0:
        col = color((iters * 10) % 255, 255, 255)
    
    #Color the block
    for x in range(width / res +1):
        for y in range(height / res + 1):
            ind = (i + x) + ((j + y) * width)
            if ind < len(pixels):
                pixels[ind] = col


#Calculates how quickly a given complex number (c) diverges when iterated on with the function 
#Z_n = (Z_n - 1)^2 + c
#Where Z_0 = 0
def sqPlus(c):  
    num = 0
    for iter in range(200):
        num *= num
        num += c
        if(abs(num) > 2):
            return iter
    return -1
        
