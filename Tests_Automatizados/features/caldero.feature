Feature: Sistema de Crafting
  Como alquimista
  Quiero poder combinar pociones en el caldero
  Para crear nuevas sustancias mágicas

  Scenario: Combinación triple exitosa
    Given el caldero está vacío
    And el jugador tiene "Potion1"
    And el jugador tiene "Potion2"
    And el jugador tiene "Potion3"
    When el jugador añade "Potion1" al caldero
    And el jugador añade "Potion2" al caldero
    And el jugador añade "Potion3" al caldero
    And el jugador interactúa con el caldero para mezclar
    Then se debe crear "Substance1"
    And "Substance1" debe ser lanzada del caldero
    And el inventario del caldero debe estar vacío

  Scenario: Combinación incompleta falla
    Given el caldero está vacío
    And el jugador tiene "Potion1"
    And el jugador tiene "Potion2"
    When el jugador añade "Potion1" al caldero
    And el jugador añade "Potion2" al caldero
    And el jugador interactúa con el caldero para mezclar
    Then no se debe crear ninguna sustancia
    And "Potion1" debe ser devuelta al mundo
    And "Potion2" debe ser devuelta al mundo
    And el inventario del caldero debe estar vacío

  Scenario: Caldero vacío no produce combinación
    Given el caldero está vacío
    When el jugador interactúa con el caldero para mezclar
    Then no debe ocurrir ninguna combinación
    Y se debe mostrar un mensaje en consola

  Scenario: Duplicados no combinan
    Given el caldero tiene 2 "Potion1"
    And el caldero tiene 1 "Potion2"
    When el jugador interactúa con el caldero para mezclar
    Then no se debe crear ninguna sustancia
    Y todas las pociones deben ser devueltas al mundo

  Scenario: Lanzamiento de objeto resultante
    Given se crea una sustancia en el caldero
    When el caldero lanza la sustancia
    Then la sustancia debe ser lanzada con física
    And la sustancia debe tener velocidad vertical
    And la sustancia debe tener dirección horizontal aleatoria
