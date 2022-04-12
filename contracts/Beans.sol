//SPDX-License-Identifier: GPL-3.0//
pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "base64-sol/base64.sol";

/// @author Pradhumna Pancholi ///
/// @title Beans ///

contract Lines is Ownable, ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    bool public paused = false;

    constructor() ERC721("Beans", "BNS") {}

    function mint() external returns (uint256) {
        require(paused == false, "Contract is paused!!!");
        _tokenIds.increment();
        uint256 tokenId = _tokenIds.current();
        _safeMint(msg.sender, tokenId);
        string memory image = getImageURI();
        string memory metadataURI = formatMetaData(image);
        _setTokenURI(tokenId, metadataURI);
        return tokenId;
    }

    function getImageURI() public pure returns (string memory) {
        string memory prefix = "data:image/svg+xml;base64,";
        string
            memory svg = '<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg"> <line x1="0" y1="80" x2="100" y2="20" stroke="black" /></svg>';
        string memory base64SVG = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        string memory assetURI = string(abi.encodePacked(prefix, base64SVG));
        return assetURI;
    }

    function formatMetaData(string memory _imageURI)
        public
        pure
        returns (string memory)
    {
        string memory prefix = "data:application/json;base64,";
        string memory base64Metadata = string(
            abi.encodePacked(
                prefix,
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name": "Beans",',
                            '"description": "An on-chain svg NFT",'
                            '"image":"',
                            _imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
        string memory metadataURI = string(
            abi.encodePacked(prefix, base64Metadata)
        );
        return metadataURI;
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
