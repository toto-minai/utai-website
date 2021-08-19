export class Window
	id = Window.UUID!

	x
	y

	xStart
	yStart

	xTranslate
	yTranslate

	ele
	outter

	isActive
	hasMoved # = false

	def dragged x, y
		xStart = x
		yStart = y
		isActive = true
		hasMoved = false
	
	def dropped
		if hasMoved
			x += xTranslate
			y += yTranslate

	def translate x, y
		xTranslate = x - xStart
		yTranslate = y - yStart

		outter.style.left = self.x + xTranslate
		outter.style.top = self.y + yTranslate

	static def UUID
		'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace /[xy]/g, do(str)
			let rand = Math.random! * 16 | 0
			return (str == 'x' ? rand : (rand & 0x3 | 0x8)).toString 16
		
	
	set coord {x, y}
		x = x
		y = y
		outter.style.top = y
		outter.style.left = x

	constructor image, page
		image = image
		page = page