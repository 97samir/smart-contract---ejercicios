// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * Demuestra:
 * - enum (Estado)
 * - struct (Alumno)
 * - arrays dinámicos y fijos
 * - array de structs
 * - push, pop, delete
 * - recorrer arrays para cálculos
 */
contract RegistroEstudiantes {
    // ===== ENUM
    enum Estado { Inactivo, Activo, Suspendido }

    // ===== STRUCT
    struct Alumno {
        address cuenta;
        string nombre;
        uint8 edad;
        Estado estado;
        uint[] notas; // array dinámico dentro del struct
    }

    // ===== ARRAYS
    Alumno[] public alumnos;               // array dinámico de structs
    uint[] public calificacionesGlobales;  // array dinámico de enteros
    uint[3] public top3;                   // array estático (tamaño fijo 3)

    // ===== EVENTOS
    event AlumnoRegistrado(uint indexed idx, address cuenta, string nombre, uint8 edad);
    event EstadoActualizado(uint indexed idx, Estado nuevo);
    event NotaAgregada(uint indexed idx, uint nota);

    // --- Alta de alumno: se agrega en estado Activo
    function registrarAlumno(string calldata nombre, uint8 edad) external returns (uint idx) {
        Alumno memory nuevo = Alumno({
            cuenta: msg.sender,
            nombre: nombre,
            edad: edad,
            estado: Estado.Activo,
            notas: new uint[](0) // inicializa array vacío
        });
        alumnos.push(nuevo);
        idx = alumnos.length - 1;
        emit AlumnoRegistrado(idx, msg.sender, nombre, edad);
    }

    // --- Cambiar estado usando enum
    function actualizarEstado(uint idx, Estado nuevoEstado) external {
        require(idx < alumnos.length, "idx invalido");
        alumnos[idx].estado = nuevoEstado;
        emit EstadoActualizado(idx, nuevoEstado);
    }

    // --- Agregar nota a un alumno (array dinamico dentro del struct)
    function agregarNota(uint idx, uint nota) external {
        require(idx < alumnos.length, "idx invalido");
        alumnos[idx].notas.push(nota);
        calificacionesGlobales.push(nota); // ejemplo de segundo array dinamico
        emit NotaAgregada(idx, nota);
    }

    // --- Promedio recorriendo array de notas
    function promedio(uint idx) external view returns (uint) {
        require(idx < alumnos.length, "idx invalido");
        uint[] storage ns = alumnos[idx].notas; // referencia storage
        if (ns.length == 0) return 0;
        uint suma = 0;
        for (uint i = 0; i < ns.length; i++) {
            suma += ns[i];
        }
        return suma / ns.length;
    }

    // --- Contar alumnos por criterio (ej.: Activos)
    function contarActivos() external view returns (uint activos) {
        for (uint i = 0; i < alumnos.length; i++) {
            if (alumnos[i].estado == Estado.Activo) {
                activos++;
            }
        }
    }

    // --- pop(): elimina el último elemento del array alumnos (reduce length en 1)
    function eliminarUltimoAlumno() external {
        require(alumnos.length > 0, "sin alumnos");
        alumnos.pop();
    }

    // --- delete: resetea a valores por defecto sin cambiar length (deja un "hueco")
    function borrarAlumno(uint idx) external {
        require(idx < alumnos.length, "idx invalido");
        delete alumnos[idx]; // nombre="", edad=0, estado=0 (Inactivo), cuenta=0x0, notas reseteado
    }

    // --- Arrays fijos: set/get para top3
    function setTop3(uint[3] calldata nuevosTop) external {
        top3 = nuevosTop; // copia elemento a elemento
    }

    function getTop3() external view returns (uint[3] memory) {
        return top3;
    }

    // --- (Opcional) Intercambiar dos alumnos usando referencias storage
    function swapAlumnos(uint i, uint j) external {
        require(i < alumnos.length && j < alumnos.length, "idx invalidos");
        if (i == j) return;
        Alumno storage A = alumnos[i];
        Alumno storage B = alumnos[j];

        // swap de campos (excepto 'notas' que tiene referencia especial; hacemos swap manual)
        (A.cuenta, B.cuenta) = (B.cuenta, A.cuenta);
        (A.nombre, B.nombre) = (B.nombre, A.nombre);
        (A.edad, B.edad) = (B.edad, A.edad);
        (A.estado, B.estado) = (B.estado, A.estado);

        // Para 'notas', un truco sencillo es copiar a memoria y reasignar:
        uint[] memory tmp = A.notas;
        A.notas = B.notas;
        B.notas = tmp;
    }

    // --- Helpers de lectura

    function totalAlumnos() external view returns (uint) {
        return alumnos.length;
    }

    function verAlumno(uint idx) external view returns (
        address cuenta,
        string memory nombre,
        uint8 edad,
        Estado estado,
        uint notasCount
    ) {
        require(idx < alumnos.length, "idx invalido");
        Alumno storage a = alumnos[idx];
        return (a.cuenta, a.nombre, a.edad, a.estado, a.notas.length);
    }

    function notasDe(uint idx) external view returns (uint[] memory) {
        require(idx < alumnos.length, "idx invalido");
        return alumnos[idx].notas;
    }
}
