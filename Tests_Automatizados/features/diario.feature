Feature: Diario de Instrucciones
  Como jugador
  Quiero poder acceder a instrucciones
  Para saber cómo jugar el juego

  Scenario: Recoger diario
    Given el diario está en el mundo
    When el jugador interactúa con el diario
    Then el diario debe ser eliminado del mundo
    And Global.has_diary debe ser true
    Y el HUD de instrucciones debe ser visible

  Scenario: Mostrar instrucciones
    Given el jugador tiene el diario
    Y el HUD de instrucciones está oculto
    When el jugador presiona la tecla M
    Then el HUD de instrucciones debe ser visible
    Y el mouse debe ser visible

  Scenario: Ocultar instrucciones
    Given el HUD de instrucciones está visible
    When el jugador presiona la tecla M
    Then el HUD de instrucciones debe ser oculto
    Y el mouse debe ser capturado

  Scenario: Intentar mostrar instrucciones sin diario
    Given el jugador no tiene el diario
    When el jugador presiona la tecla M
    Then las instrucciones no deben aparecer
    Y no debe haber cambio en el estado del mouse

  Scenario: Diario es visible en el mundo
    Given el juego inicia
    Then el diario debe ser visible en el mundo 3D
    Y el diario debe tener un modelo 3D
