// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToDynamicArray {
    uint256[] writeHere;

    function main(uint256[] memory x) external {
        assembly {
            // getting array length
            let length := mload(x)

            // compute memory location of first element
            let mloc := add(x, 0x20)

            // compute storage location of first element
            mstore(0x00, writeHere.slot)
            let sloc := keccak256(0x00, 0x20)

            // store length
            sstore(writeHere.slot, length)

            for { let i := 0 } lt(i, length) { i := add(i, 1) } {
                sstore(add(sloc, i), mload(mloc))
                mloc := add(mloc, 0x20)
            }
        }
    }

    function getter() external view returns (uint256[] memory) {
        return writeHere;
    }
}
// Hint: https://www.rareskills.io/post/solidity-dynamic
