// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts@4.9.3/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.9.3/access/Ownable.sol";

contract AcademicCertificate is ERC721URIStorage, Ownable {
    uint256 private _nextTokenId = 1;

    // Solo para pruebas, nunca usar nombres reales en producción
    struct CertificateData {
        string studentName;       
        string institutionName;
        string courseName;
        bool isRevoked;
    }

    mapping(uint256 => CertificateData) public certificates;

    event CertificateIssued(uint256 tokenId, address to, string courseName);
    event CertificateRevoked(uint256 tokenId);

    constructor() ERC721("AcademicCertificateNFT", "ACERT") {}

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

    /*
     Revocar, solo el propietario del contrato (la institución) 
     puede realizar esta acción.
     */
    function revokeCertificate(uint256 tokenId) public onlyOwner {
        require(_exists(tokenId), "El certificado no existe");

        require(!certificates[tokenId].isRevoked, "El certificado ya fue revocado");
        certificates[tokenId].isRevoked = true;
        emit CertificateRevoked(tokenId);
    }

    /**
    Verifica si un certificado sigue siendo válido.
    Retorna true si el certificado no ha sido revocado.
     */
    function isCertificateValid(uint256 tokenId) public view returns (bool) {
        require(_exists(tokenId), "El certificado no existe");
        return !certificates[tokenId].isRevoked;
    }
}

