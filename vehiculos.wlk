class Torino {
  var property velocidadMaxima
  var property color
  var property autonomia

  method capacidad() {
    return 4
  }

  method elMotorEsRuidoso() {
    return true
  }
  
  method puedeTransportarSillas() {
    return false
  }



}


class Economico {
  const property color = "Beige"
  var property adaptaciones = #{}

  method capacidad() {
    return self.capacidadBase() - adaptaciones.sum({adaptacion => adaptacion.cantPlazaOcupada()})
  }

  method velocidadMaxima() {
    if (adaptaciones == #{}){
      return 120
    }else {
      return adaptaciones.map({adaptacion => adaptacion.velocidadDeVehiculoRequerido()}).min()
    }
  } 

  method puedeTransportarSillas() {
    return adaptaciones.contains(transportadorParaSillaDeRuedas)
  }

  method elMotorEsRuidoso() {
    return not adaptaciones.any({adaptacion => adaptacion.reduceElRuido()})
  }

  method autonomia() {
    if(adaptaciones == #{}){
      return 200
    }else{
      return 200 + adaptaciones.sum({adaptacion => adaptacion.cantAportaAutonomia()})
    }
  }

  method capacidadBase() {
    return 5
  }

}

object transportadorParaSillaDeRuedas {
  method cantPlazaOcupada() {
    return 1
  }

  method velocidadDeVehiculoRequerido() {
    return 90
  }

  method reduceElRuido(){
    return false
  }

  method cantAportaAutonomia() {
    return -(20)
  }
}

object cañoDeEscapeSilencioso {
  method cantPlazaOcupada() {
    return 0
  }
  
  method velocidadDeVehiculoRequerido() {
    return 115
  }

  method reduceElRuido(){
    return true
  }

  method cantAportaAutonomia() {
    return -(10)
  }
}

object tanqueExtraDeGas {
  
  method cantPlazaOcupada() {
    return 1
  }

  method velocidadDeVehiculoRequerido() {
    return 80
  }

  method reduceElRuido(){
    return true
  }

  method cantAportaAutonomia() {
    return 200
  }
  
}

object combiAdaptable {
  var interior = interiorAccessible
  var motor =  motorUrbano
  
  method color() {
    return "Celeste"
  }

  method cambiarInterior(interiorNuevo) {
    interior = interiorNuevo
  }

  method cambiarMotor(motorNuevo) {
    motor = motorNuevo
  }

  method capacidad() {
    return interior.capacidad()
  }

  method autonomia() {
    return motor.autonomia()
  }

  method velocidadMaxima() {
    return motor.velocidadMaxima()
  }

  method elMotorEsRuidoso() {
    return motor.elMotorEsRuidoso()
  }

  method puedeTransportarSillas() {
    return interior.puedeTransportarSillas()
  }


}

object interiorEspacioso {

  method capacidad() {
    return 7
  }

  method puedeTransportarSillas() {
    return false
  }
  
}

object interiorAccessible {

  method capacidad() {
    return 5
  }

  method puedeTransportarSillas() {
    return true
  }  
  
}

object motorDeportivo {

  method velocidadMaxima() {
    return 230
  }

  method autonomia() {
    return 400
  }

  method elMotorEsRuidoso() {
    return true
  }

}

object motorUrbano {

  method velocidadMaxima() {
    return 130
  }

  method autonomia() {
    return 1000
  }

  method elMotorEsRuidoso() {
    return false
  }  
  
}