Feature: Gestión de Inventario
  Como jugador
  Quiero poder gestionar mi inventario
  Para poder recolectar y usar ítems durante mi aventura

  Scenario: Abrir inventario con tecla TAB
    Given el jugador está en el juego
    And el inventario está cerrado
    When el jugador presiona la tecla TAB
    Then el inventario debe ser visible
    And el mouse debe ser visible
    And Global.isInventary debe ser true

  Scenario: Cerrar inventario con tecla TAB
    Given el inventario está abierto
    When el jugador presiona la tecla TAB
    Then el inventario debe ser oculto
    And el mouse debe ser capturado
    And Global.isInventary debe ser false

  Scenario: Arrastrar ítem entre slots
    Given el inventario está abierto
    And el slot A contiene "Potion1"
    And el slot B está vacío
    When el jugador arrastra el ítem del slot A al slot B
    Then el slot B debe contener "Potion1"
    And el slot A debe estar vacío

  Scenario: Soltar ítem del inventario al mundo
    Given el inventario está abierto
    And hay una poción en un slot
    When el jugador arrastra la poción fuera del inventario
    Then la poción debe aparecer en el mundo 3D
    And la poción debe ser eliminada del inventario

  Scenario: Verificar tooltip de ítem
    Given el inventario está abierto
    Y hay un ítem en un slot
    When el jugador pasa el mouse sobre el ítem
    Then debe mostrarse un tooltip con el nombre del ítem

  Scenario: Inventario con slots suficientes
    Given el juego inicia
    When se carga el inventario
    Then debe tener al menos 6 slots disponibles
