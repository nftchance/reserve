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

    /// @dev Keeps track of the address that the Reserve is deployed to.
    uint256 public reserveNumber;

    /// @dev Keeps track of what contracts the contract being actively 
    //       deployed can call. This uses a latent state approach.
    bytes32[] public typeHashes;

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

    /**
     * @notice Deploys a new Reserve that the deployer can manage.
     * @param _typeHashes The type hashes of the functions that can be called.
     * @return reserve The address of the new Reserve.
     * @return index The index used to instantiate the new Reserve.
     */
    function deployAReserve(
        bytes32[] memory _typeHashes
    )
        external
        returns (
              AReserve reserve
            , uint256 index
        )
    { 
        unchecked { index = reserveNumber++; }

        /// @dev Set the index that is used to control the Reserve deployment address.
        reserveNumber = index + 1;

        /// @dev Set the functions that can be called through this Reserve.
        typeHashes = _typeHashes;

        /// @dev Deploy the Reserve.
        reserve = new AReserve{salt: bytes32(index)}();

        /// @dev Emit the event.
        emit ReserveDeployed(
              index
            , reserve
            , msg.sender
        );
    }

    /**
     * @notice Allows the deployment of reserves without parameters beyond salt.
     * @return Array of type hashes that define which function this contract can call. 
     */
    function getReserveTypeHashes()
        external
        view
        returns (
            bytes32[] memory
        )
    {
        return typeHashes;
    }
}