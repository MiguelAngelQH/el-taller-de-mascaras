Feature: Recolección de Pociones
  Como aventurero
  Quiero poder recoger pociones del mundo
  Para usarlas en mi aventura

  Scenario: Recoger poción del mundo
    Given hay una "Potion1" en el mundo
    And el inventario tiene un slot vacío
    When el jugador se acerca a la poción
    And el jugador presiona la tecla E
    Then la "Potion1" debe ser eliminada del mundo
    And la "Potion1" debe aparecer en el inventario
    Y el sonido de la poción debe reproducirse si existe

  Scenario: Recoger poción con inventario lleno
    Given hay una "Potion1" en el mundo
    And el inventario está lleno
    When el jugador se acerca a la poción
    And el jugador presiona la tecla E
    Then la "Potion1" debe permanecer en el mundo
    Y se debe mostrar un mensaje de inventario lleno

  Scenario: Soltar poción del inventario
    Given el inventario está abierto
    Y hay una poción en un slot
    When el jugador arrastra la poción fuera del inventario
    Then la poción debe aparecer en el mundo 3D
    Y la poción debe ser eliminada del inventario

  Scenario: Poción reproduce sonido al recoger
    Given hay una "Potion2" en el mundo
    Y "Potion2" tiene sonido asociado
    And el inventario tiene espacio
    When el jugador recoge la "Potion2"
    Then el sonido de "Potion2" debe reproducirse

  Scenario: Poción tiene datos correctos
    Given se carga "Potion1"
    Then "Potion1" debe tener un nombre
    And "Potion1" debe tener un icono
    Y "Potion1" debe tener un mesh 3D
