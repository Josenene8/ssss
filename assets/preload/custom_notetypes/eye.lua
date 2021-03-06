function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'eye' then --Check if the note on the chart is a Eye Note
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'eye'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashHue', 0); --custom notesplash color, why not
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashSat', -20);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashBrt', 1);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has penalties
			end
		end
	end
end

local shootAnims = {"singLEFT-alt", "singDOWN-alt", "singUP-alt", "singRIGHT-alt"}
function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'eye' then
		if difficulty == 1 then
			playSound('laugh', 0.5);
		elseif difficulty == 2 then
			playSound('laugh', 0.7);
		end
		characterPlayAnim('dad', shootAnims[direction + 1], false);
		characterPlayAnim('boyfriend', 'dodge', true);
		setProperty('boyfriend.specialAnim', true);
		setProperty('dad.specialAnim', true);
		cameraShake('camGame', 0.01, 0.2)
    end
end
	function noteMiss(id, direction, noteType, isSustainNote)
		if noteType == 'eye' and difficulty == 0 then
			setProperty('health', getProperty('health')-0.5);
			runlaughr('bleed', 0.1, 20);
			playSound('hurt', 0.6);
			characterPlayAnim('boyfriend', 'hurt', true);
		end
		if noteType == 'eye' and difficulty == 1 then
			setProperty('health', -2);
			playSound('laugh', 0.5);
			characterPlayAnim('boyfriend', 'hurt', true);
		end
		if noteType == 'eye' and difficulty == 2 then
			setProperty('health', -2);
			playSound('laugh', 0.5);
			characterPlayAnim('boyfriend', 'hurt', true);
		end
	end
	
function onlaughrCompleted(tag, loops, loopsLeft)
	-- A loop from a laughr you called has been completed, value "tag" is it's tag
	-- loops = how many loops it will have done when it ends completely
	-- loopsLeft = how many are remaining
		if tag == 'bleed' then
			setProperty('health', getProperty('health')-0.01);
		end
end