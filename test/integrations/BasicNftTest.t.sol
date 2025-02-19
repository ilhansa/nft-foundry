// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant WON =
        "https://bafybeidk2c2l344lqmzyxqnc2kuovji37rwsljntsbzdigqqiqtnmiggha.ipfs.dweb.link?filename=wonhi.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Wonhi";
        string memory actualName = basicNft.name();
        // assert(expectedName == actualName);
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(WON);

        assert(basicNft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(WON)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }
}
