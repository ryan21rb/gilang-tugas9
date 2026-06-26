pragma circom 2.2.3;

include "node_modules/circomlib/circuits/poseidon.circom";

template Auth() {
    // Cukup gunakan 'signal input' saja
    signal input secret; 
    signal input publicHash;

    component hasher = Poseidon(1);
    hasher.inputs[0] <== secret;

    // hasher.out === publicHash;
}

component main = Auth();