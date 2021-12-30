function onCreate()
	-- background stuffs
	-- high y low height, high x rightmore
	makeLuaSprite('bacck', 'bacck', -600, 0);
	setScrollFactor('bacck', 0.9, 0.9);

	makeLuaSprite('trey', 'trey', -900, -850);
	setScrollFactor('trey', 0.7, 0.7);

	if not lowQuality then
		makeLuaSprite('signrotta', 'signrotta', 800, 400);
		setScrollFactor('signrotta', 0.9, 0.9);
		scaleObject('signrotta', 0.8, 0.8);

	end

	addLuaSprite('bacck', false);
	addLuaSprite('trey', false);
	addLuaSprite('signrotta', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end