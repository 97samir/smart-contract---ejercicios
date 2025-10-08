// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title AcademicCertificate
 * @dev Contrato inteligente que representa certificados académicos como NFTs (ERC-721).
 * Cada certificado se almacena como un token único vinculado a metadatos en IPFS.
 * Este contrato está diseñado con fines educativos y de demostración.
 */

import "@openzeppelin/contracts@4.9.3/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.9.3/access/Ownable.sol";

contract AcademicCertificate is ERC721URIStorage, Ownable {
    uint256 private _nextTokenId = 1;

    struct CertificateData {
        string studentName;       // Solo para pruebas, nunca usar nombres reales en producción
        string institutionName;
        string courseName;
        bool isRevoked;
    }

    mapping(uint256 => CertificateData) public certificates;

    event CertificateIssued(uint256 tokenId, address to, string courseName);
    event CertificateRevoked(uint256 tokenId);

    constructor() ERC721("AcademicCertificateNFT", "ACERT") {}

    /**
     * @notice Emite un nuevo certificado académico como NFT.
     * @dev Solo la institución (owner del contrato) puede emitir certificados.
     * @param to Dirección del destinatario (cuenta del estudiante en MetaMask).
     * @param tokenURI Enlace IPFS del metadato JSON (con hash único del certificado).
     * @param studentName Nombre del estudiante (solo en pruebas).
     * @param institutionName Nombre de la institución educativa.
     * @param courseName Nombre del curso o programa académico.
     */
    function issueCertificate(
        address to,
        string memory tokenURI,
        string memory studentName,
        string memory institutionName,
        string memory courseName
    ) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _mint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);

        certificates[tokenId] = CertificateData({
            studentName: studentName,
            institutionName: institutionName,
            courseName: courseName,
            isRevoked: false
        });

        emit CertificateIssued(tokenId, to, courseName);
    }

    /**
     * @notice Revoca un certificado emitido previamente.
     * @dev Solo el propietario del contrato (la institución) puede realizar esta acción.
     */
    function revokeCertificate(uint256 tokenId) public onlyOwner {
        require(_exists(tokenId), "El certificado no existe");

        require(!certificates[tokenId].isRevoked, "El certificado ya fue revocado");
        certificates[tokenId].isRevoked = true;
        emit CertificateRevoked(tokenId);
    }

    /**
     * @notice Verifica si un certificado sigue siendo válido.
     * @param tokenId Identificador del certificado NFT.
     * @return true si el certificado no ha sido revocado.
     */
    function isCertificateValid(uint256 tokenId) public view returns (bool) {
        require(_exists(tokenId), "El certificado no existe");
        return !certificates[tokenId].isRevoked;
    }
}

