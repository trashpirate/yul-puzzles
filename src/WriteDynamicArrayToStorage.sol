// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteDynamicArrayToStorage {
    uint256[] public writeHere;

    function main(uint256[] calldata x) external {
        assembly {
            // get array length
            let offset := add(0x04, calldataload(0x04))
            let length := calldataload(offset)

            // compute location of first element in calldata
            let cdloc := add(0x20, offset)

            // compute location of first element in storage
            mstore(0x00, writeHere.slot)
            let sloc := keccak256(0x00, 0x20)

            // store length
            sstore(writeHere.slot, length)

            // looping through elements
            for { let i := 0 } lt(i, length) { i := add(i, 1) } {
                sstore(add(sloc, i), calldataload(cdloc))
                cdloc := add(cdloc, 0x20)
            }
        }
    }
}
