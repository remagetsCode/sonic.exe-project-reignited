import openfl.utils.Assets;
import flixel.text.FlxText.FlxTextBorderStyle;
using StringTools;

playCutscenes = true;

var tails:FlxSprite;
var jumpscare:FlxSprite;
var kadeText:FlxText;

function create() {
    FlxG.save.data.ogTitle = true;
    FlxG.sound.play(Paths.sound('jumpscare'), 0);

    if (FlxG.save.data.cached == false || FlxG.save.data.cached == null){
        Assets.loadBitmapData(Paths.image('og/jumpscare'));
        FlxG.save.data.cached = true;
    }
}

function postCreate() {
    tails = new FlxSprite(-190, 0);
    tails.frames = Paths.getFrames('og/tails');
    tails.animation.addByPrefix('idle', 'idle', 12);
    tails.animation.play('idle');
    tails.scale.set(1.5, 1.5);
    insert(members.indexOf(eggman)+1, tails);

    jumpscare = new FlxSprite();
    jumpscare.frames = Paths.getFrames('og/jumpscare');
    jumpscare.animation.addByPrefix('jumpscare', 'jumpscare', 24, false);
    jumpscare.alpha = 0;
    jumpscare.screenCenter(FlxAxes.X);
    add(jumpscare);
    jumpscare.camera = camHUD;

    kadeText = new FlxText(20, (Options.downscroll ? 10 : FlxG.height-30), 600, 'too-slow - Hard | KE 1.5.4', 12).setFormat(null, 12, 0xFFFFFFFF, 'left', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    kadeText.camera = camHUD;
    add(kadeText);

    ratingShit = new FlxText(0, healthBar.y + (Options.downscroll ? -60 : 40), 700, 'Score: 0 | Combo Breaks: 0 | Accuracy: 0%').setFormat(null, 14, 0xFFFFFFFF, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    ratingShit.screenCenter(FlxAxes.X);
    insert(20, ratingShit);
    ratingShit.camera = camHUD;

    scoreTxt.visible = missesTxt.visible = accuracyTxt.visible = false;
}

function postUpdate(elapsed:Float) {
	ratingShit.text = 'Score: '+songScore+' | Combo Breaks: '+misses+' | Accuracy: '+ (FlxMath.roundDecimal(accuracy*100, 2) != -100 ? FlxMath.roundDecimal(accuracy*100, 2) : 0) +'%';

    var char = strumLines.members[(curCameraTarget != -1 ? (curCameraTarget != 2 ? curCameraTarget : 1) : 0)].characters[0];
    var animName = char.animation.curAnim.name;

    if (!animName.contains("sing")) theFuckingMovement(0, 0);
       
    if (!animName.contains("miss") && animName.contains("sing")) {
        if (animName.startsWith("singLEFT")) theFuckingMovement(-30, 0);
        else if (animName.startsWith("singDOWN")) theFuckingMovement(0, 30);
        else if (animName.startsWith("singUP")) theFuckingMovement(0, -30);
        else if (animName.startsWith("singRIGHT")) theFuckingMovement(30, 0);
    }
}

function stepHit(s:Int) {
    switch(s){
        case 1305: FlxTween.tween(camHUD, {alpha: 0}, 1, {ease: FlxEase.quadInOut});
        case 1432: FlxTween.tween(camHUD, {alpha: 1}, 1, {ease: FlxEase.quadInOut});
        case 1722:
            jumpscare.alpha = 1;
            jumpscare.animation.play('jumpscare');
            FlxG.sound.play(Paths.sound('jumpscare'), 0.8);
        case 1736:
            remove(jumpscare);
            jumpscare.destroy();
    }
}

function onPlayerHit(e) e.note.splash = "squirt";

function destroy() {
    FlxG.save.data.cached = false;
    FlxG.save.data.ogTitle = false;
}

function theFuckingMovement(x:Float, y:Float) camGame.targetOffset.set(x, y);