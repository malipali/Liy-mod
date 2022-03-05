function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Knife note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Knifenote' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'knifeNoteAsset'); --Change texture
				setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'KNIFEnoteSplashes'); --Change splash

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has penalties
					playSound('slice', 0.5)
			end
		end
	end
	--debugPrint('Script started!')
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Knifenote' then
		playSound('slice', 0.3)
		characterPlayAnim('boyfriend', 'dodge', true);
		characterPlayAnim('dad', 'hey', true);
		setProperty('boyfriend.specialAnim', true);
		setProperty('dad.specialAnim', true);
	end
end

-- Called after the note miss calculations
-- Player missed a note by letting it go offscreen
function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == 'Knifenote' then
		playSound('slice', 0.3)
			health = getProperty('health')
				if getProperty('health') > 0.05 then
			setProperty('health', health- 0.7);
		end
	end
end