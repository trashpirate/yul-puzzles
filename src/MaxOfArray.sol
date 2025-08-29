// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract MaxOfArray {
    function main(uint256[] memory arr) external pure returns (uint256) {
        assembly {
            // your code here
            // return the maximum value in the array
            // revert if array is empty
            let length := mload(arr)
            let ptr := add(arr, 0x20)
            let max
            for { let i := ptr } lt(i, add(ptr, mul(length, 0x20))) { i := add(i, 0x20) } {
                let x := mload(i)
                if gt(x, max) { max := x }
            }
            mstore(mload(0x40), max)
            return(mload(0x40), 0x20)
        }
    }
}
