module starter :: starter{
    use std::debug::print;
    use std::string::{String,utf8};

    public struct Usuario has drop{
        nombre: String,
        edad: u8,
        vivo: bool,
    }

    fun practica(usuario: Usuario){
        if (usuario.edad > 18) {
         print (&utf8(b"Acceso permitido"));
         print (&utf8(b"Acceso permitido"));
         print (&utf8(b"Acceso permitido"));
        }
        else if (usuario.edad == 18) {
            print (&utf8(b"Felicidades!"));
        }
        else {
            print (&utf8(b"Acceso no permitido"));
        }
    }

    #[test]
    fun prueba() {
        let usuario = Usuario {
            nombre: utf8(b"Juan Sanchez"),
            edad: 20,
            vivo: true,
        };
        practica(usuario);
    }
}