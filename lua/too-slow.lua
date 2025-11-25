function onStepHit()
    if curStep == 750 then
        -- Aplica el shader a los personajes principales
        setSpriteShader('boyfriend', 'firelight')
        setSpriteShader('dad', 'firelight')
        setSpriteShader('gf', 'firelight')

        -- Aplica el shader al HUD (opcional)
        setCamShader('camHUD', 'firelight')

        -- Aplica el shader a la cámara del juego (fondo, escenario, etc.)
        setCamShader('camGame', 'firelight')
    end
end
