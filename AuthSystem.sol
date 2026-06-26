// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./verifier.sol"; 

contract AuthSystem {
    // Sesuai dengan nama contract di verifier.sol kamu
    Groth16Verifier public verifier;
    
    mapping(address => uint256) public userCommitments;

    constructor(address _verifierAddress) {
        verifier = Groth16Verifier(_verifierAddress);
    }

    // REGISTRASI
    function register(uint256 _publicHash) public {
        userCommitments[msg.sender] = _publicHash;
    }

    // LOGIN
    function login(
        uint[2] memory a,
        uint[2][2] memory b,
        uint[2] memory c,
        uint[1] memory input
    ) public view returns (bool) {
        // Cek proof valid
        require(verifier.verifyProof(a, b, c, input), "Proof tidak valid!");
        
        // Cek apakah publicHash benar
        require(userCommitments[msg.sender] == input[0], "Hash tidak cocok!");
        
        return true; 
    }
}