//SPDX-License-Identifier: GPL-3.0//
pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

/// @author Pradhumna Pancholi ///
/// @title Beans ///

contract Beans is ERC721URIStorage {
    constructor() ERC721("Beans", "BNS") {}
}
