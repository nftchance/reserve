// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import { AReserve } from "./AReserve.sol";

import { Auth, Authority } from "solmate/src/auth/Auth.sol";
import { Bytes32AddressLib } from "solmate/src/utils/Bytes32AddressLib.sol";

contract TheReserve is 
    Auth 
{
    using Bytes32AddressLib for address;
    using Bytes32AddressLib for bytes32;

    uint256 public reserveNumber;

    string public reserveDeploymentName;

    event ReserveDeployed(
          uint256 indexed index
        , AReserve indexed reserve
        , address indexed deployer
    );

    /**
     * @notice Creates a Reserve Factory to deploy new Reserves.
     * @param _owner The owner of the Reserve Factory.
     * @param _authority The authority of the Reserve Factory.
     */
    constructor(
          address _owner
        , Authority _authority
    ) 
        Auth(
              _owner
            , _authority
        ) 
    {}

    function deployAReserve(
          string memory _name
        , bytes32[] memory _typeHashes
    )
        external
        returns (
              AReserve reserve
            , uint256 index
        )
    { 
        unchecked { index = reserveNumber++; }

        reserveNumber = index + 1;
        reserveDeploymentName = _name;

        reserve = new AReserve{salt: bytes32(index)}(
            _typeHashes
        );

        emit ReserveDeployed(
              index
            , reserve
            , msg.sender
        );
    }
}