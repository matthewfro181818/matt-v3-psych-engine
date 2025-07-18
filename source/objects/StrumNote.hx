package objects;

import backend.animation.PsychAnimationController;

import shaders.RGBPalette;
import shaders.RGBPalette.RGBShaderReference;

class StrumNote extends FlxSprite
{
	public var rgbShader:RGBShaderReference;
	public var resetAnim:Float = 0;
	private var noteData:Int = 0;
	public var direction:Float = 90;//plan on doing scroll directions soon -bb
	public var downScroll:Bool = false;//plan on doing scroll directions soon -bb
	public var sustainReduce:Bool = true;
	private var player:Int;
	
	public var texture(default, set):String = null;
	private function set_texture(value:String):String {
		if(texture != value) {
			texture = value;
			reloadNote();
		}
		return value;
	}

	public var sustainSplash:SustainSplash;

	public var useRGBShader:Bool = true;
	public function new(x:Float, y:Float, leData:Int, player:Int) {
		animation = new PsychAnimationController(this);

		rgbShader = new RGBShaderReference(this, Note.initializeGlobalRGBShader(leData));
		rgbShader.enabled = false;
		if(PlayState.SONG != null && PlayState.SONG.disableNoteRGB) useRGBShader = false;

		var arrayToIndex = ClientPrefs.data.arrowRGB;
		if(PlayState.isPixelStage) arrayToIndex = ClientPrefs.data.arrowRGBPixel;
		if (PlayState.keyCount != 4) arrayToIndex = PlayState.multikeyRGBColors[PlayState.keyCount];
		
		var arr:Array<FlxColor> = arrayToIndex[leData];
		
		@:bypassAccessor
		{
			rgbShader.r = arr[0];
			rgbShader.g = arr[1];
			rgbShader.b = arr[2];
		}

		noteData = leData;
		this.player = player;
		this.noteData = leData;
		super(x, y);

		var skin:String = null;
		if(PlayState.SONG != null && PlayState.SONG.arrowSkin != null && PlayState.SONG.arrowSkin.length > 1) skin = PlayState.SONG.arrowSkin;
		else skin = Note.defaultNoteSkin;

		var customSkin:String = skin + Note.getNoteSkinPostfix();
		if(Paths.fileExists('images/$customSkin.png', IMAGE)) skin = customSkin;

		texture = skin; //Load texture and anims
		scrollFactor.set();
		sustainSplash = new SustainSplash(this);
	}

	public function reloadNote()
	{
		var lastAnim:String = null;
		if(animation.curAnim != null) lastAnim = animation.curAnim.name;

		var noteIndex = PlayState.multikeyNoteAnimIndexes[PlayState.keyCount][noteData];

		if(PlayState.isPixelStage)
		{
			loadGraphic(Paths.image('pixelUI/' + texture));
			width = width / 4;
			height = height / 5;
			loadGraphic(Paths.image('pixelUI/' + texture), true, Math.floor(width), Math.floor(height));

			antialiasing = false;
			setGraphicSize(Std.int(width * PlayState.daPixelZoom));

			animation.add('green', [6]);
			animation.add('red', [7]);
			animation.add('blue', [5]);
			animation.add('purple', [4]);
			switch (Math.abs(noteIndex) % 4)
			{
				case 0:
					animation.add('static', [0]);
					animation.add('pressed', [4, 8], 12, false);
					animation.add('confirm', [12, 16], 24, false);
				case 1:
					animation.add('static', [1]);
					animation.add('pressed', [5, 9], 12, false);
					animation.add('confirm', [13, 17], 24, false);
				case 2:
					animation.add('static', [2]);
					animation.add('pressed', [6, 10], 12, false);
					animation.add('confirm', [14, 18], 12, false);
				case 3:
					animation.add('static', [3]);
					animation.add('pressed', [7, 11], 12, false);
					animation.add('confirm', [15, 19], 24, false);
			}
		}
		else
		{
			frames = Paths.getSparrowAtlas(texture);
			animation.addByPrefix('green', 'arrowUP');
			animation.addByPrefix('blue', 'arrowDOWN');
			animation.addByPrefix('purple', 'arrowLEFT');
			animation.addByPrefix('red', 'arrowRIGHT');

			antialiasing = ClientPrefs.data.antialiasing;
			setGraphicSize(Std.int(width * PlayState.multikeyScales[PlayState.keyCount]));

			switch (Math.abs(noteIndex) % 5)
			{
				case 0:
					animation.addByPrefix('static', 'arrowLEFT');
					animation.addByPrefix('pressed', 'left press', 24, false);
					animation.addByPrefix('confirm', 'left confirm', 24, false);
				case 1:
					animation.addByPrefix('static', 'arrowDOWN');
					animation.addByPrefix('pressed', 'down press', 24, false);
					animation.addByPrefix('confirm', 'down confirm', 24, false);
				case 2:
					animation.addByPrefix('static', 'arrowUP');
					animation.addByPrefix('pressed', 'up press', 24, false);
					animation.addByPrefix('confirm', 'up confirm', 24, false);
				case 3:
					animation.addByPrefix('static', 'arrowRIGHT');
					animation.addByPrefix('pressed', 'right press', 24, false);
					animation.addByPrefix('confirm', 'right confirm', 24, false);
				case 4: 
					animation.addByPrefix('static', 'arrowSPACE');
					animation.addByPrefix('pressed', 'space press', 24, false);
					animation.addByPrefix('confirm', 'space confirm', 24, false);
			}
		}
		updateHitbox();

		if(lastAnim != null)
		{
			playAnim(lastAnim, true);
		}
	}

	public function postAddedToGroup() {
		playAnim('static');
		x += PlayState.multikeyWidths[PlayState.keyCount] * 0.7 * noteData;
		x += 50;
		x += ((FlxG.width / 2) * player);
		x -= PlayState.multikeyOffset[PlayState.keyCount];
		ID = noteData;
	}

	public function playerPosition()
	{
		x += Note.swagWidth * noteData;
		x += 50;
		x += ((FlxG.width / 2) * player);
	}

	override function update(elapsed:Float) {
		if(resetAnim > 0) {
			resetAnim -= elapsed;
			if(resetAnim <= 0) {
				playAnim('static');
				resetAnim = 0;
			}
		}
		super.update(elapsed);
	}

	public function playAnim(anim:String, ?force:Bool = false) {
		animation.play(anim, force);
		if(animation.curAnim != null)
		{
			centerOffsets();
			centerOrigin();
		}
		if(useRGBShader) rgbShader.enabled = (animation.curAnim != null && animation.curAnim.name != 'static');
	}

	public function setRGBShaderToStrum() {
		shader = rgbShader.parent.shader;
	}
	public function getBrightenedPrimaryNoteColor() {
		var color = rgbShader.r;
		if (color == 0xFF000000) color = 0xFF010101; //idk stupid shit with full black color
		return FlxColor.fromHSB(color.hue, color.saturation, 1).toHexString(false,false);
	}
}

class SustainSplash extends FlxSprite {
	public var rgbShader:RGBShaderReference;
	public var strum:StrumNote;
	override public function new(strum:StrumNote) {
		super();
		this.strum = strum;

		@:privateAccess
		rgbShader = new RGBShaderReference(this, Note.initializeGlobalRGBShader(strum.noteData));

		frames = Paths.getSparrowAtlas("noteSplashes/sustain_cover");
		animation.addByPrefix('cover', 'sustain cover pre0', 24, false);
		animation.addByPrefix('splash', 'sustain cover end0', 24, false);
		animation.addByPrefix('loop', 'sustain cover0', 24);
		animation.play("loop");
		updateHitbox();
		visible = false;
		antialiasing = ClientPrefs.data.antialiasing;

		scale.set(strum.scale.x / 0.7, strum.scale.y / 0.7);
		updateHitbox();
	}

	public var updatedThisFrame:Bool = false;

	public inline function show() {
		updatedThisFrame = true;
		visible = true;
		if (animation.curAnim.name != "loop") {
			animation.play("cover");
			center();
		}
	}
	public inline function hide(miss:Bool = false) {
		if (animation.curAnim.name == "splash") return;

		updatedThisFrame = true;
		if (miss) visible = false;
		if (animation.curAnim.name != "splash") {
			animation.play("splash");
			center();
		}
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updatedThisFrame = false;

		if (animation.curAnim.finished) {
			if (animation.curAnim.name == "cover") animation.play("loop");
			if (animation.curAnim.name == "splash") visible = false;
		}
		
		//if (animation.curAnim.name != "splash") center();
		//updateHitbox();
		center();
	}

	public function center() {
		centerOffsets();
		x = strum.x + (strum.width/2) - (width/2);
		y = strum.y + (strum.height/2) - (height/2);
	}
}
