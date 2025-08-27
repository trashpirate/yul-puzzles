// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract RevertWithSelectorPlusArgs {
    error RevertData(uint256); // selector: 0xae412287

    function main(uint256 x) external pure {
        assembly {
            // your code here
            // revert custom error with x parameter
            // Hint: concatenate selector and x by storing them
            // adjacent to each other in memory
            mstore(0x00, shl(224, 0xae412287)) // store selector for "Error(string)"
            mstore(0x04, x) // store offset to string: 32 (0x20) bytes
            revert(0x00, 0x24)
        }
    }
}
