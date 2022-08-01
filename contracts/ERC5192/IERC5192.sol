// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

interface IERC5192 {
    function locked(uint256 tokenId) external view returns (bool);
}
