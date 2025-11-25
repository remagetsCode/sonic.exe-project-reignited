import hxvlc.flixel.FlxVideoSprite;
import flixel.math.FlxMath;

var intro:FlxVideoSprite;

function create() {
    FlxG.sound.music.stop();

    var back = new FlxVideoSprite();
    back.alpha = 0.001;
    back.load(Paths.video('back'), [':no-audio']);
    add(back);
    back.play();
    
    add(intro = new FlxVideoSprite(-320, -180));
	intro.scale.set(0.67, 0.67);
	intro.updateHitbox();
	if (intro.load(Paths.video('gameIntro'))) new FlxTimer().start(1, ()->intro.play());

	intro.bitmap.onEndReached.add(() -> {
		remove(intro);
		intro.destroy();
        FlxG.switchState(new MainMenuState());
	});
}

function update(elapsed:Float) {
	if (controls.ACCEPT){
		remove(intro);
		intro.destroy();
		FlxG.switchState(new MainMenuState());
	}
}