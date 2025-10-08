// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title BancoDePuntosBasico
 * Demuestra:
 * - Variables de estado (globales del contrato): owner, bloqueCreacion, balances, ultimaOperacion
 * - Variables globales EVM: msg.sender, block.timestamp, block.number
 * - Variables locales: usadas en depositar/retirar para cálculos temporales
 * - mapping: balances por address, ultimaOperacion por address
 */
contract BancoDePuntosBasico {
    // ===== Variables de estado (persisten en la cadena)
    address public owner;
    uint256 public bloqueCreacion;

    mapping(address => uint256) private balances;
    mapping(address => uint256) private ultimaOperacion;

    // ===== Eventos (útiles para inspeccionar en Remix)
    event Depositado(address indexed usuario, uint256 monto, uint256 timestamp);
    event Retirado(address indexed usuario, uint256 monto, uint256 timestamp);

    constructor() {
        owner = msg.sender;              // global: quién despliega
        bloqueCreacion = block.number;   // global: número de bloque al desplegar
    }

    // ===== Acciones

    /// @notice Suma puntos al saldo del remitente.
    function depositar(uint256 monto) external {
        require(monto > 0, "monto debe ser > 0");

        // variable local para claridad didactica
        uint256 nuevoSaldo = balances[msg.sender] + monto;
        balances[msg.sender] = nuevoSaldo;

        // global: block.timestamp
        ultimaOperacion[msg.sender] = block.timestamp;

        emit Depositado(msg.sender, monto, block.timestamp);
    }

    function bonus() external {
        uint256 nuevoSaldo = balances[msg.sender] + 20;
        balances[msg.sender] = nuevoSaldo;

        ultimaOperacion[msg.sender] = block.timestamp;
    }

    /// @notice Resta puntos del saldo del remitente si hay fondos suficientes.
    function retirar(uint256 monto) external {
        require(monto > 0, "monto debe ser > 0");

        // variable local
        uint256 saldoPrevio = balances[msg.sender];
        require(saldoPrevio >= monto, "saldo insuficiente");

        // variable local (opcional) para mostrar otro ejemplo
        uint256 nuevoSaldo = saldoPrevio - monto;
        balances[msg.sender] = nuevoSaldo;

        ultimaOperacion[msg.sender] = block.timestamp;
        emit Retirado(msg.sender, monto, block.timestamp);
    }

    // ===== Lecturas

    function saldoDe(address usuario) external view returns (uint256) {
        return balances[usuario];
    }

    function ultimaFechaOp(address usuario) external view returns (uint256) {
        return ultimaOperacion[usuario];
    }

    function bloqueDeCreacion() external view returns (uint256) {
        return bloqueCreacion;
    }
}