Feature: Sistema de Diálogos
  Como jugador
  Quiero experimentar la historia del juego
  A través de diálogos interactivos

  Scenario: Iniciar diálogo
    Given el jugador está en la escena principal
    When el diálogo se inicia automáticamente
    Then el mouse debe ser visible
    Y el diálogo debe mostrarse en pantalla
    Y el texto debe aparecer letra por letra

  Scenario: Avanzar en diálogo
    Given un diálogo está activo
    When el jugador presiona la tecla de avance
    Then el texto debe aparecer completamente
    Y el diálogo debe pasar a la siguiente línea

  Scenario: Seleccionar opción
    Given un diálogo tiene opciones de elección
    When el jugador selecciona una opción
    Then el diálogo debe continuar según la elección
    Y las consecuencias de la elección deben aplicarse

  Scenario: Terminar diálogo
    Given un diálogo está activo
    When el diálogo termina
    Then el mouse debe ser capturado
    Y el diálogo debe desaparecer
    Y el juego debe continuar

  Scenario: Diálogo es skippable
    Given un diálogo está activo
    When el jugador presiona la tecla de skip
    Then todo el texto debe aparecer instantáneamente
    Y el jugador puede avanzar rápidamente
