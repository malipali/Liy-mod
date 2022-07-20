local allowCountdown = false
local boyfriend = bf
local inSelection = true
local ofsx = -210
local ofsy = 0
local mult = 1.25
characterNames = {'bf', 'pico-player'} --character json name
characterDisplays = {'boyfriend', 'pico'} --display name for text
characterLimit = {3, 1} --how many variations does the character have
maxpage = 2 --amount of characters u have
variation = 1 -- 1 = original
local page = 1
local inSelection = true
function onCreate()
  if allowCountdown == false then
    makeLuaSprite('fader', '', -200, -200)
    makeGraphic('fader', 1920, 1080, '000000')
    addLuaSprite('fader', true)
    setScrollFactor('fader', 0, 0)
    setProperty('fader.alpha', 0)
    setObjectCamera('fader', 'other')

  	makeLuaSprite('1', 'stageback', -600, -300);
  	setScrollFactor('1', 0.9, 0.9);

  	makeLuaSprite('2', 'stagefront', -650, 600);
  	setScrollFactor('2', 0.9, 0.9);
  	scaleObject('2', 1.1, 1.1);

		makeLuaSprite('3', 'stage_light', -125, -100);
		setScrollFactor('3', 0.9, 0.9);
		scaleObject('3', 1.1, 1.1);

		makeLuaSprite('4', 'stage_light', 1225, -100);
		setScrollFactor('4', 0.9, 0.9);
		scaleObject('4', 1.1, 1.1);
		setProperty('4.flipX', true); --mirror sprite horizontally

		makeLuaSprite('5', 'stagecurtains', -500, -300);
		setScrollFactor('5', 1.3, 1.3);
		scaleObject('5', 0.9, 0.9);

  	addLuaSprite('1', false);
  	addLuaSprite('2', false);
  	addLuaSprite('3', false);
  	addLuaSprite('4', false);
  	addLuaSprite('5', false);
    makeLuaText('text1', characterDisplays[page], 600, 15, 350)
    setTextSize('text1', 50);--Sets text size
    setTextWidth('text1', 600);--Sets text width
    addLuaText('text1')
    setProperty('gf.visible', false)
    setProperty('dad.visible', false)
    playMusic('offsetSong')
  end
end
function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and not isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
    setProperty('gf.visible', false)
    setProperty('dad.visible', false)
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end
function onUpdate()
  if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') then
    if inSelection == true and getProperty('inCutscene') == true then
      removeLuaText('text1', true)
      stopSound('offsetSong`')
      playMusic('gameOverEnd', 0.5)
      if page < 3 then
        objectPlayAnimation('boyfriend', 'hey', true)
      else
        objectPlayAnimation('boyfriend', 'singUP', true)
      end
      runTimer('startsong', 5)
      runTimer('fadein', 2.5)
      runTimer('fadedelay', 1.5)
      setProperty('seenCutscene', true)
    end
  end
  if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.BACKSPACE') then
    endSong()
  end
  if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.RIGHT') then
    if page < maxpage and inSelection == true then
      variation = 1
      page = page+1
      --debugPrint(page, characterNames[page], characterDisplays[page], variation)
      setCharacter()
    end
  elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.LEFT') then
    if page > 0 and inSelection == true then
      variation = 1
      page = page-1
      --debugPrint(page, characterNames[page], characterDisplays[page], variation)
      setCharacter()
    end
  end


  if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.UP') then
    if variation < characterLimit[page] and inSelection == true then
      variation = variation+1
      --debugPrint(page, characterNames[page], characterDisplays[page], variation)
      setCharacter()
    end
  elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.DOWN') then
    if variation > -1 and inSelection == true then
      variation = variation-1
      --debugPrint(page, characterNames[page], characterDisplays[page], variation)
      setCharacter()
    end
  end
  --animation player
  if inSelection == true then
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.D') then
      objectPlayAnimation('boyfriend', 'singLEFT', true)
    elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.J') then
      objectPlayAnimation('boyfriend', 'singUP', true)
    elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F') then
      objectPlayAnimation('boyfriend', 'singDOWN', true)
    elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.K') then
      objectPlayAnimation('boyfriend', 'singRIGHT', true)
    elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.G') then
      objectPlayAnimation('boyfriend', 'hey', true)
    elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.H') then
      objectPlayAnimation('boyfriend', 'idle', true)
    end
  end
end
function onTimerCompleted(tag)
  if tag == 'startsong' then
    startCountdown()
  end
  if tag == 'fadein' then
    inSelection = false
    setProperty('dad.visible', true)
    if page == 1 then
      setProperty('gf.visible', true)
    end
    removeLuaSprite('1', true)
    removeLuaSprite('2', true)
    removeLuaSprite('3', true)
    removeLuaSprite('4', true)
    removeLuaSprite('5', true)
    runTimer('fadeout', 2.5)
  end
  if tag == 'fadedelay' then
    doTweenAlpha('faderfader', 'fader', 1, 0.9, 'linear')
  end
end
function setCharacter()
  if page > 0 and page < maxpage+1 and inSelection == true then
    setVariation()
    setTextString('text1', characterDisplays[page]);
    --setProperty('boyfriend', 'x', defaultBoyfriendX+characterOfsX[page])
    --setProperty('boyfriend', 'y', defaultBoyfriendY+characterOfsY[page])
    triggerEvent('Change Character', 0, characterNames[page]);
    objectPlayAnimation('boyfriend', 'idle', true)
  end
end
function setVariation()
  if variation == 1 then
    characterNames = {'bf', 'pico-player'} --character json name
    characterDisplays = {'boyfriend', 'pico'} --display name for text
  elseif variation == 2 then
    characterNames = {'bf-christmas', 'pico-player'} --character json name
    characterDisplays = {'boyfriend (christmas)', 'pico'} --display name for text
  elseif variation == 3 then
    characterNames = {'bf-pixel', 'pico-player'} --character json name
    characterDisplays = {'boyfriend (pixel)', 'pico'} --display name for text
  end
end
function onTweenCompleted(tag)
  if tag == 'faderfader' then
    doTweenAlpha('faderfaderBYE', 'fader', 0, 1.4, 'linear')
  end
end