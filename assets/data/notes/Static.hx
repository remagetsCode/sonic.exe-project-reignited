function onNoteCreation(e) {
    if (e.noteType == 'Static') {
        e.noteSprite = 'game/notes/static';
    }
}

function onPostNoteCreation(e) {
    if (e.noteType == 'Static') {
        e.note.offset.x = 43;
        e.note.offset.y = (Options.downscroll ? 50 : 35);
    }
}

function onStrumCreation(e) {
    if (e.noteType == 'Static') {
        e.sprite = 'game/notes/static';
    }
}