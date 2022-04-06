local allowCountdown = false;
local playDialogue = false;
function onStartCountdown()
		initSaveData('sus', 'elimination')
		SetDataFromSave('sus', 'played', 'true')
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
		startVideo('testVideo');
		allowCountdown = true;
		playDialogue = true;
		return Function_Stop;
	elseif playDialogue then
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		playDialogue = false;
		return Function_Stop;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		getDataFromSave(sus, played)
		if played == false then
		startDialogue('dialogue', 'breakfast');
		else
		startDialogue('dialogue3', 'breakfast');
		end
	end
end

-- Dialogue (When a dialogue is finished, it calls startCountdown again)
function onNextDialogue(count)
	-- triggered when the next dialogue line starts, 'line' starts with 1
end

function onSkipDialogue(count)
	-- triggered when you press Enter and skip a dialogue line that was still being typed, dialogue line starts with 1
end

local allowEndShit = false

function onEndSong()
  if not allowEndShit and isStoryMode then
    setProperty('inCutscene', true);
    startDialogue('dialogue2', 'breakfast'); 
    allowEndShit = true;
    return Function_Stop;
  end
  return Function_Continue;
end
