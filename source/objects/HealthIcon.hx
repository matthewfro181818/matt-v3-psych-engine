package objects;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;
	private var isOldIcon:Bool = false;
	private var isPlayer:Bool = false;
	private var char:String = '';

	public var isAnimated:Bool = false;

	public function new(char:String = 'bf', isPlayer:Bool = false, ?allowGPU:Bool = true)
	{
		super();
		isOldIcon = (char == 'bf-old');
		this.isPlayer = isPlayer;
		changeIcon(char, allowGPU);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 12, sprTracker.y - 30);
	}

	private var iconOffsets:Array<Float> = [0, 0];
	private var perAnimIconOffsets:Array<Array<Float>> = [[0,0], [0,0]];
	public function changeIcon(char:String, ?allowGPU:Bool = true) {
		if(this.char != char) {
			var name:String = 'icons/' + char;
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-' + char; //Older versions of psych engine's support
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-face'; //Prevents crash from missing icon

			if(Paths.fileExists('images/' + name + '.xml', TEXT)) {
				isAnimated = true;
				frames = Paths.getSparrowAtlas(name, null, allowGPU);
				animation.addByPrefix('default', 'default', 24, true);
				animation.addByPrefix('losing', 'losing', 24, true);

				animation.play('losing');
				updateHitbox();
				perAnimIconOffsets[1][0] = (width - 150) / 2;
				perAnimIconOffsets[1][1] = (height - 150) / 2;

				animation.play('default');
				updateHitbox();
				perAnimIconOffsets[0][0] = (width - 150) / 2;
				perAnimIconOffsets[0][1] = (height - 150) / 2;
				

			} else {
				var graphic = Paths.image(name, allowGPU);
				loadGraphic(graphic, true, Math.floor(graphic.width / 2), Math.floor(graphic.height));
				iconOffsets[0] = (width - 150) / 2;
				iconOffsets[1] = (height - 150) / 2;
				updateHitbox();
	
				animation.add(char, [0, 1], 0, false, isPlayer);
				animation.play(char);
			}
			
			
			this.char = char;

			if(char.endsWith('-pixel'))
				antialiasing = false;
			else
				antialiasing = ClientPrefs.data.antialiasing;
		}
	}

	var curAnimFrame:Int = 0;

	public var autoAdjustOffset:Bool = true;

	override function updateHitbox()
	{
		super.updateHitbox();
		offset.x = iconOffsets[0] + perAnimIconOffsets[curAnimFrame%perAnimIconOffsets.length][0];
		offset.y = iconOffsets[1] + perAnimIconOffsets[curAnimFrame%perAnimIconOffsets.length][1];
		if(autoAdjustOffset)
		{
			offset.x = iconOffsets[0];
			offset.y = iconOffsets[1];
		}
	}

	public function setAnimFrame(num:Int) {
		if (isAnimated) {
			animation.play(curAnimFrame == 1 ? 'losing' : 'default');
		} else {
			animation.curAnim.curFrame = num;
		}
		curAnimFrame = num;
	}

	public function getCharacter():String {
		return char;
	}
}