Feature: Menú Principal
  Como jugador
  Quiero navegar por el menú principal
  Para iniciar o salir del juego

  Scenario: Iniciar juego
    Given el jugador está en el menú principal
    When el jugador presiona el botón Start
    Then la escena principal debe cargar
    Y el diálogo inicial debe iniciarse

  Scenario: Ver créditos
    Given el jugador está en el menú principal
    When el jugador presiona el botón Credits
    Then la escena de créditos debe cargar
    Y debe mostrarse información del equipo

  Scenario: Salir del juego
    Given el jugador está en el menú principal
    When el jugador presiona el botón Quit
    Then el juego debe cerrarse

  Scenario: Navegación entre opciones
    Given el jugador está en el menú principal
    When el jugador usa las teclas de dirección
    Then la selección debe moverse entre opciones
    Y la opción seleccionada debe ser visible

  Scenario: Menú tiene diseño visual apropiado
    Given el juego inicia
    Then el menú principal debe ser visible
    Y debe tener un título
    Y debe tener botones interactivos
