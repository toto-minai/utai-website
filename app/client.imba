import './css/style.css'

class Window
	constructor image, page
		image = image
		page = page

let windows = [
	new Window('https://chunghwa.asia/utai/screenshots/screenshot_page_2_1.png', 2)
	new Window('https://chunghwa.asia/utai/screenshots/screenshot_page_2_2.png', 2)
	new Window('https://chunghwa.asia/utai/screenshots/screenshot_page_2_4.png', 2)
	new Window('https://chunghwa.asia/utai/screenshots/screenshot_page_3_1.png', 3)
	new Window('https://chunghwa.asia/utai/screenshots/screenshot_page_3_2.png', 3)
	new Window('https://chunghwa.asia/utai/screenshots/screenshot_page_3_3.png', 3)
]

# tag WindowItem
# 	<self.outter_page_{window.page}.outter>
# 		<div.inner_page_{window.page}.inner>
# 			<img.screenshot_page_{window.page}_img.screenshot.item
# 				src="{window.image}">  

tag app
	<self>
		<> for window in windows
			<div.outter_page_{window.page}.outter>
				<div.inner_page_{window.page}.inner>
					<img.screenshot_page_{window.page}_img.screenshot.item
						src="{window.image}">

imba.mount <app>