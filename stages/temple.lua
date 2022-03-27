function onCreate()
	-- background stuffs
	-- high y low height, high x rightmore
	makeLuaSprite('ruinsb', 'ruinsb', -600, 0);
	setScrollFactor('ruinsb', 0.7, 0.7);

	makeLuaSprite('tempself', 'tempself', -1200, -650);
	setScrollFactor('tempself', 0.9, 0.9);

	if not lowQuality then
		makeLuaSprite('tempfr', 'tempfr', 900, 0);
		setScrollFactor('tempfr', 0.6, 0.6);

	end

	addLuaSprite('ruinsb', false);
	addLuaSprite('tempself', false);
	addLuaSprite('tempfr', true);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end