// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract RevertWithError {
    function main() external pure {
        assembly {
            // revert the function with an error of type `Error(string)`
            // use "RevertRevert" as error message
            // Hint: The error type is a predefined four bytes. See https://www.rareskills.io/post/try-catch-solidity
            mstore(0x00, shl(224, 0x08c379a0)) // store selector for "Error(string)"
            mstore(0x04, 0x20) // store offset to string: 32 (0x20) bytes
            mstore(0x24, 0xc) // length of string: 12 characters => 12 bytes
            mstore(0x44, "RevertRevert") // store data
            revert(0x00, 0x64) // return 4 words of 32 bytes
        }
    }
}
