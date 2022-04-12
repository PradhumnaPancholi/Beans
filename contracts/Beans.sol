//SPDX-License-Identifier: GPL-3.0//
pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "base64-sol/base64.sol";

/// @author Pradhumna Pancholi ///
/// @title Beans ///

contract Beans is Ownable, ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    bool public paused = false;
    string constant URI =
        "ipfs://QmWxGQE4t8LvSUTznadopLGzq9byNWttEg8XYUpvYh18T1";

    constructor() ERC721("Beans", "BNS") {}

    function mint() external returns (uint256) {
        require(paused == false, "Contract is paused!!!");
        _tokenIds.increment();
        uint256 tokenId = _tokenIds.current();
        _safeMint(msg.sender, tokenId);
        string memory tokenURI = formatMetaData("test");
        _setTokenURI(tokenId, tokenURI);
        return tokenId;
    }

    function getImageURI() public pure returns (string memory) {
        string memory prefix = "data:image/svg+xml;base64,";
        string base64SVG = Base64.encode(bytes(string(abi.encodePacked(svg))));
    }

    function formatMetaData(string memory _imageURI)
        public
        pure
        returns (string memory)
    {
        string memory prefix = "data:application/json;base64,";
        return
            string(
                abi.encodePacked(
                    prefix,
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "Beans",',
                                '"description": "An on-chain svg NFT",'
                                // '"image":"', _imageURI,'"}"
                            )
                        )
                    )
                )
            );
    }

    function pause() external onlyOwner returns (bool) {
        paused = true;
        return paused;
    }

    function resume() external onlyOwner returns (bool) {
        paused = false;
        return paused;
    }
}
