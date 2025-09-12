module starter::practica_sui;

use std::String::String;

public struct Veterinaria has Key{
    id:UID
    nombre: String,
    mascotas: vector<Mascota>,
}

public struct Mascota has store, drop {
    nombre: String,
    edad: u16,
    especie: String;
    foto: String,
    estado: String,
}

public fun crear_veterinaria(nombre: String, ctx: &mut TxContext){
    let veterinaria=Veterinaria {id: object::new(ctx), nombre,mascotas: vector[] };
    transfer::tranfer(veterinaria, tx_context::sender(ctx));
}

public fun agregar_mascota(veterinaria: &mut Veterinaria, nombre: String, edad: u16, especie: String, foto: String){
    let mascota = Mascota {nombre, edad, especie, foto}:
    veterinaria.mascotas.push_back(mascota)
}

public fun eliminar_ultima_mascota(veterinaria: &mut Veterinaria){
    veterinaria.mascotas.pop_back();
}

public fun eliminar_mascota(veterinaria: &mut Veterinaria, id u64){
    assert!(veterinaria.mascotas.lenght() > id, ID_NO_EXISTE);
}

public fun editar_estado(veterinaria: &mut Veterinaria, id: u64, estado: String){
    let mascota = veterinaria.mascotas.borrow_mut(id);
    mascota.estado = estado;
}