module starter :: taller{
   use std::string::{String};
   use sui::vec_map::{VecMap, Self};

   #[error]
   const ID_YA_EXISTE: vector<u8> = b"El ID que se intento insertar ya existe.";

   #[error]
   const ID_NO_EXISTE: vector<u8> = b"No existe un cliente con el ID proporcionado.";

   public struct Taller has key {
        id: UID,
        nombre: String,
        cliente: VecMap<u64, Cliente>,

   }

   public struct Cliente has store, drop {
        nombre_Cliente: String,
        modelo_Vehiculo: u8,
        color: String,
        reparado: bool,
        estado: String, 
   }

   public fun crear_taller(nombre: String, ctx: &mut TxContext){
    let taller = Taller {
        id: object::new(ctx),
        nombre,
        cliente: vec_map::empty(),
    };

    transfer::transfer(taller, tx_context::sender(ctx));

   }

   public fun agregar_cliente(taller: &mut Taller, id: u64, nombre_Cliente: String, modelo_Vehiculo: u8, color: String, reparado: bool,estado: String){
        assert! (!taller.cliente.contains(&id),ID_YA_EXISTE);

        let cliente=Cliente {
            nombre_Cliente,
            modelo_Vehiculo,
            color,
            diagnosticado: true,
            estado,
        };
        taller.cliente.insert(id, cliente);
   }

public fun eliminar_cliente(taller: &mut Taller, id: u64) {
    assert!(taller.cliente.contains(&id), ID_NO_EXISTE);
    taller.cliente.remove(&id);
}

}
