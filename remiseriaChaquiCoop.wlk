import reservas.*
class RemiseriaChaquiCoop {
  var property flota = []
  var property historialDeViajes = []


  method vehiculosQueCumplenConReserva(reserva) {
    return flota.filter({vehiculo => self.reservaPuedeSerCumplidaPor(reserva, vehiculo)})    
  }
  
  method registrarViaje(reserva,vehiculo) {
    self.validarVehiculo(vehiculo,reserva)
    historialDeViajes.add(new Viaje(vehiculoUsado = vehiculo, reservaDada = reserva))
  }

  method validarVehiculo(vehiculoDado,reserva) {
    if (not (flota.any({vehiculo => vehiculo == vehiculoDado}) && self.reservaPuedeSerCumplidaPor(reserva,vehiculoDado))){
      self.error("No es valido el vechiculo")
    }
  }

  method todosLasReservasQueTiene(vehiculo) {
    return self.viajesQueHiso(vehiculo).map({viaje => viaje.reservaDada()})
  }

  method distanciaTotalDe(vehiculo) {
    return self.viajesQueHiso(vehiculo).sum({viaje => viaje.distanciaRecorrida()})
  }

  method viajesQueHiso(vehiculo) {
    return historialDeViajes.filter({viaje => viaje.vehiculoUsado() == vehiculo})
  }



  method reservaPuedeSerCumplidaPor(reserva,vehiculo) {
     return 
        vehiculo.capacidad() >= reserva.capacidad() &&
      vehiculo.velocidadMaxima() >= (reserva.distancia()/reserva.tiempoMaximoDeViajeEnHoras()) + 10 &&
      not reserva.coloresContraindicados().any({color => color == vehiculo.color()}) &&
      self.siNecesitaSilla(reserva.necesitaLlevarSillasDeRuedas(), vehiculo.puedeTransportarSillas()) &&
      self.NecesitaSilencio(reserva.necesitaQueSeaSilencioso(),vehiculo.elMotorEsRuidoso()) &&
      vehiculo.autonomia() >= reserva.distancia() 
  }

  method siNecesitaSilla(reservaNecesita,vehiculoTiene) { //OJO
      if (reservaNecesita){
        return vehiculoTiene
      }else{
        return true
      }
  }

  method NecesitaSilencio(reservaNecesita,vehiculoTiene) {
      if (reservaNecesita){
        return not vehiculoTiene
      }else{
        return true
      }      
  } 
}

class Viaje {
  var property vehiculoUsado
  var property reservaDada

  method distanciaRecorrida() {
    return reservaDada.distancia()
  }
}