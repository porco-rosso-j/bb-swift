use bb_rs::barretenberg_api::{
    ecdsa::{
        ecdsa__compute_public_key, ecdsa__construct_signature,
        ecdsa__recover_public_key_from_signature, ecdsa__verify_signature,
    },
    grumpkin::{ecc_grumpkin__add, ecc_grumpkin__mul},
    models::{Fr, Point},
    pedersen::{pedersen_commit, pedersen_hash},
    poseidon2::poseidon2_hash,
    traits::{DeserializeBuffer, SerializeBuffer},
};

#[swift_bridge::bridge]
mod ffi {
    extern "Rust" {
        type Fr;
        type Point;

        fn pedersen_commit_swift(inputs: &[u8]) -> Vec<u8>;
        fn pedersen_hash_swift(inputs: &[u8]) -> Vec<u8>;
        fn poseidon2_hash_swift(inputs: &[u8]) -> Vec<u8>;
        fn ecdsa__compute_public_key_swift(private_key: &[u8]) -> Vec<u8>;
        fn ecdsa__construct_signature_swift(
            message: &[u8],
            msg_len: usize,
            private_key: &[u8],
        ) -> Vec<u8>;
        fn ecdsa__recover_public_key_from_signature_swift(
            message: &[u8],
            msg_len: usize,
            sig_r: &[u8],
            sig_s: &[u8],
            sig_v: u8,
        ) -> Vec<u8>;
        fn ecdsa__verify_signature_swift(
            message: &[u8],
            msg_len: usize,
            public_key: &[u8],
            sig_r: &[u8],
            sig_s: &[u8],
            sig_v: u8,
        );
        fn ecc_grumpkin__mul_swift(point_buf: &[u8], scalar_buf: &[u8]) -> Vec<u8>;
        fn ecc_grumpkin__add_swift(point_a_buf: &[u8], point_b_buf: &[u8]) -> Vec<u8>;
    }
}

pub fn pedersen_commit_swift(inputs: &[u8]) -> Vec<u8> {
    let input: [u8; 32] = inputs.try_into().unwrap();
    let result: Point = unsafe { pedersen_commit(&[Fr::from_buffer(input)]) };
    result.to_buffer()
}

pub fn pedersen_hash_swift(inputs: &[u8]) -> Vec<u8> {
    let input: [u8; 32] = inputs.try_into().unwrap();
    let result: Fr = unsafe { pedersen_hash(&[Fr::from_buffer(input)], 0u32) };
    result.to_buffer()
}

pub fn poseidon2_hash_swift(inputs: &[u8]) -> Vec<u8> {
    let input: [u8; 32] = inputs.try_into().unwrap();
    let result: Fr = unsafe { poseidon2_hash(&[Fr::from_buffer(input)]) };
    result.to_buffer()
}
pub fn ecdsa__compute_public_key_swift(private_key: &[u8]) -> Vec<u8> {
    let result = unsafe { ecdsa__compute_public_key(&private_key) };
    result.to_vec()
}

pub fn ecdsa__construct_signature_swift(
    message: &[u8],
    msg_len: usize,
    private_key: &[u8],
) -> Vec<u8> {
    let (sig_r, sig_s, sig_v) =
        unsafe { ecdsa__construct_signature(&message, msg_len, &private_key) };
    let mut result = Vec::with_capacity(65);
    result.extend(sig_r);
    result.extend(sig_s);
    result.push(sig_v);

    result
}
pub fn ecdsa__recover_public_key_from_signature_swift(
    message: &[u8],
    msg_len: usize,
    sig_r: &[u8],
    sig_s: &[u8],
    sig_v: u8,
) -> Vec<u8> {
    let mut _sig_v = sig_v;
    let result = unsafe {
        ecdsa__recover_public_key_from_signature(&message, msg_len, &sig_r, &sig_s, &mut _sig_v)
    };

    result.to_vec()
}
pub fn ecdsa__verify_signature_swift(
    message: &[u8],
    msg_len: usize,
    public_key: &[u8],
    sig_r: &[u8],
    sig_s: &[u8],
    sig_v: u8,
) {
    let mut _sig_v = sig_v;
    let result =
        unsafe { ecdsa__verify_signature(&message, msg_len, &public_key, &sig_r, &sig_s, _sig_v) };
}

pub fn ecc_grumpkin__mul_swift(point_a_buf: &[u8], point_b_buf: &[u8]) -> Vec<u8> {
    let result = unsafe { ecc_grumpkin__mul(&point_a_buf, &point_b_buf) };
    result.to_vec()
}

pub fn ecc_grumpkin__add_swift(point_a_buf: &[u8], point_b_buf: &[u8]) -> Vec<u8> {
    let result = unsafe { ecc_grumpkin__add(&point_a_buf, &point_b_buf) };
    result.to_vec()
}
