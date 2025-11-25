function onNoteCreation(e) {
    if (e.noteType == 'StaticAlt') {
        e.noteSprite = 'game/notes/static';
    }
}

function onPostNoteCreation(e) {
    if (e.noteType == 'StaticAlt') {
        e.note.offset.x = 43;
        e.note.offset.y = (Options.downscroll ? 50 : 35);
    }
}

function onStrumCreation(e) {
    if (e.noteType == 'StaticAlt') {
        e.sprite = 'game/notes/static';
    }
}

function onNoteHit(event) if (event.noteType == "StaticAlt") event.animSuffix = "-alt";
function onPlayerMiss(event) if (event.noteType == "StaticAlt") event.animSuffix = "miss-alt";