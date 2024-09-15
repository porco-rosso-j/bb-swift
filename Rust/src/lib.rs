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

// use swift_bridge::ffi::FfiSlice;

#[swift_bridge::bridge]
mod ffi {
    extern "Rust" {
        type Fr;
        type Point;

        fn pedersen_commit_swift(inputs: &[u8]) -> Vec<u8>;
        fn pedersen_hash_swift(inputs: &[u8], index: u32) -> Vec<u8>;
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

// pub fn pedersen_commit_swift(inputs: &[u8]) -> Vec<u8> {
//     let input: [u8; 32] = inputs.try_into().unwrap();
//     let result: Point = unsafe { pedersen_commit(&[Fr::from_buffer(input)]) };
//     result.to_buffer()
// }

// pub fn pedersen_hash_swift(inputs: &[&[u8]]) -> Vec<u8> {
//     let input: [u8; 32] = inputs.try_into().unwrap();
//     let result: Fr = unsafe { pedersen_hash(&[Fr::from_buffer(input)], 0u32) };
//     result.to_buffer()
// }

// pub fn poseidon2_hash_swift(inputs: &[u8]) -> Vec<u8> {
//     let input: [u8; 32] = inputs.try_into().unwrap();
//     let result: Fr = unsafe { poseidon2_hash(&[Fr::from_buffer(input)]) };
//     result.to_buffer()
// }

pub fn pedersen_commit_swift(inputs: &[u8]) -> Vec<u8> {
    let fr_count = inputs.len() / 32;
    let mut fr_inputs = Vec::with_capacity(fr_count);
    for i in 0..fr_count {
        let start = i * 32;
        let end = start + 32;
        let input_slice = &inputs[start..end];
        let fr = Fr::from_buffer(
            <[u8; 32]>::try_from(input_slice).expect("Each input must be exactly 32 bytes"),
        );
        fr_inputs.push(fr);
    }

    let result: Point = unsafe { pedersen_commit(&fr_inputs) };
    result.to_buffer()
}

pub fn pedersen_hash_swift(inputs: &[u8], index: u32) -> Vec<u8> {
    let fr_count = inputs.len() / 32;
    let mut fr_inputs = Vec::with_capacity(fr_count);
    for i in 0..fr_count {
        let start = i * 32;
        let end = start + 32;
        let input_slice = &inputs[start..end];
        let fr = Fr::from_buffer(
            <[u8; 32]>::try_from(input_slice).expect("Each input must be exactly 32 bytes"),
        );
        fr_inputs.push(fr);
    }

    let result: Fr = unsafe { pedersen_hash(&fr_inputs, index) };
    result.to_buffer()
}

pub fn poseidon2_hash_swift(inputs: &[u8]) -> Vec<u8> {
    let fr_count = inputs.len() / 32;
    let mut fr_inputs = Vec::with_capacity(fr_count);
    for i in 0..fr_count {
        let start = i * 32;
        let end = start + 32;
        let input_slice = &inputs[start..end];
        let fr = Fr::from_buffer(
            <[u8; 32]>::try_from(input_slice).expect("Each input must be exactly 32 bytes"),
        );
        fr_inputs.push(fr);
    }

    let result: Fr = unsafe { poseidon2_hash(&fr_inputs) };
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

#[cfg(test)]
mod tests {
    use super::*; // Assuming pedersen_hash_swift is in the same module

    #[test]
    fn test_pedersen_hash_swift() {
        // Define the input values as arrays of u8 slices
        let inputs: &[&[u8]] = &[
            &[
                6, 196, 4, 126, 220, 48, 240, 65, 72, 173, 40, 101, 187, 150, 245, 115, 253, 193,
                91, 5, 45, 148, 91, 74, 184, 111, 200, 144, 36, 203, 76, 229,
            ],
            &[
                6, 196, 4, 126, 220, 48, 240, 65, 72, 173, 40, 101, 187, 150, 245, 115, 253, 193,
                91, 5, 45, 148, 91, 74, 184, 111, 200, 144, 36, 203, 76, 229,
            ],
        ];

        // Define the hash index as u32
        let index: u32 = 0;

        // Call the pedersen_hash_swift function
        let result = pedersen_hash_swift(inputs, &index);

        // Expected result length (since it's returning a Vec<u8>)
        assert_eq!(result.len(), 32); // Assuming the result should be 32 bytes

        // Optional: print the result for manual inspection
        println!("Pedersen hash result: {:?}", result);

        // Add more specific assertions if you know the expected hash result
        // e.g. assert_eq!(result, expected_result); if you have an expected output.
    }
}
