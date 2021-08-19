import { Window } from './window'
import { Desktop } from './desktop'
import './css/style.css'

const windows = [
	new Window 'https://chunghwa.asia/utai/screenshots/screenshot_page_2_1.png', 2
	new Window 'https://chunghwa.asia/utai/screenshots/screenshot_page_2_2.png', 2
	new Window 'https://chunghwa.asia/utai/screenshots/screenshot_page_2_4.png', 2
	new Window 'https://chunghwa.asia/utai/screenshots/screenshot_page_3_1.png', 3
	new Window 'https://chunghwa.asia/utai/screenshots/screenshot_page_3_2.png', 3
	new Window 'https://chunghwa.asia/utai/screenshots/screenshot_page_3_3.png', 3
]

tag WindowItem
	prop window_

	<self.outter_page_{window_.page}.outter>
		<div.inner_page_{window_.page}.inner>
			<img.screenshot_page_{window_.page}_img.screenshot.item
				src=window_.image>

tag DesktopTag
	<self>
		<> for window in windows
			<WindowItem window_=window>

imba.mount <DesktopTag>


const body = document.getElementsByTagName("body")[0]
let desktop = new Desktop
	body
	document.getElementsByClassName "outter"
	body.scrollWidth
	body.scrollHeight

window.onload = do
	for outter, i in desktop.outters
		let window = windows[i]
		window.outter = outter
		window.ele = outter.querySelector ".item"
		
		const x = Math.random! * (desktop.width - outter.clientWidth)
		const y = Math.random! * (desktop.height - outter.clientHeight)
		window.coord = {x, y}

		desktop.normalLayerUUIDs.push window.id

	body.addEventListener "touchstart", drag, no
	body.addEventListener "touched", drop, no
	body.addEventListener "touchmove", move, no

	body.addEventListener "mousedown", drag, no
	body.addEventListener "mouseup", drop, no
	body.addEventListener "mousemove", move, no

	body.style.opacity = 1


def drag e
	e.preventDefault!

	if desktop.activeWindow
		desktop.activeWindow.dropped!
	
	windows.forEach do(window)
		if window.ele is e.target
			desktop.activeWindow = window
			desktop.normalLayerUUIDs =
				desktop.normalLayerUUIDs.filter do(uuid)
					uuid != window.id
			desktop.normalLayerUUIDs.push window.id
	
	# No window is active 
	unless desktop.activeWindow
		return
	
	windows.forEach do(window)
		const index = desktop.normalLayerUUIDs.indexOf window.id
		const zIndex = index + 1
		window.outter.style.zIndex = zIndex
		if index == desktop.normalLayerUUIDs.length - 1
			window.outter.style.boxShadow = '0 16px 40px rgba(0, 0, 0, 0.72)'
		else
			window.outter.style.boxShadow = '0 8px 20px rgba(0, 0, 0, 0.36)'
	
	if e.type is "touchstart"
		desktop.activeWindow.dragged
			e.touches[0].clientX
			e.touches[0].clientY
	else
		desktop.activeWindow.dragged
			e.clientX, e.clientY

def drop e
	unless desktop.activeWindow
		return

	desktop.activeWindow.dropped!
	desktop.activeWindow = null

def move e
	if desktop.activeWindow
		desktop.activeWindow.hasMoved = yes

		if e.type is "touchmove"
			desktop.activeWindow.translate
				e.touches[0].clientX
				e.touches[0].clientY
		else
			desktop.activeWindow.translate
				e.clientX, e.clientY