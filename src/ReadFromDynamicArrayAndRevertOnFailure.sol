// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromDynamicArrayAndRevertOnFailure {
    uint256[] readMe;

    function setValue(uint256[] calldata x) external {
        readMe = x;
    }

    function main(int256 index) external view returns (uint256) {
        assembly {
            // your code here
            // read the value at the `index` in the dynamic array `readMe`
            // and return it
            // Revert with Solidity panic on failure, use error code 0x32 (out-of-bounds or negative index)
            // Hint: https://www.rareskills.io/post/solidity-dynamic
            let len := sload(readMe.slot)
            if lt(sub(len, 1), index) {
                mstore(0x40, shl(224, 0x4e487b71)) // store selector for "Panic(uint256)"
                mstore(0x44, 0x32) // store error code
                revert(0x40, 0x24)
            }
            mstore(0x40, readMe.slot)
            let loc := keccak256(0x40, 0x20)
            mstore(0x40, sload(add(loc, index)))
            return(0x40, 0x20)
        }
    }
}
