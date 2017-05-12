require 'rails_helper'

describe "Map", type: :feature do
	it "should load the map", js: true do
		visit root_path
		map = page.evaluate_script("$('.leaflet-container').length")
		expect(map).to eq(1)
	end

	it "should map zoom be at 16", js: true do
		visit root_path
		zoom = page.evaluate_script("map.getZoom()")
		expect(zoom).to eq(16)
	end

	it "should not show the sidebar when you open the map", js: true do
		visit root_path
		sidebar = page.evaluate_script("$('#sidebar').html()")
		expect(sidebar).to be_empty
	end

	it "should show the sidebar when click on building", js: true do
		visit root_path
		sidebarclick = page.evaluate_script("map._layers['105'].fire('click')")
		expect(sidebarclick).to eq(1)
		# clicar em um building
		# expect(sidebar). to be_visible()


		# sidebar = page.evaluate_script("$('#sidebar').html()")
		# expect(sidebar).to be_empty
	  end

end
