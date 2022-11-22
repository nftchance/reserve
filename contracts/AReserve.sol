// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

// TODO: Think the 4626 vault needs to be a separate contract.
//       This would mean that the caller and "creditor" and "debtor"
//       would always be the same address and the vault would be
//       the only address that could transfer tokens as well as 
//       the only address that could call the vault's functions as 
//       the calling is not permissioned and is instead based on 
//       the flow of money in and out of the Vault.

contract AReserve { 
    /// @dev The Type Hashes of the functions that can be called.
    /// @notice This cannot be immutable because it is an array of bytes32 but there is no way to 
    ///         update this value so it is "conceptually" immutable.
    bytes32[] public typeHashes;

    constructor(
        bytes32[] memory _typeHashes
    ) {
        /// @dev This enables the ability to set the functions that can be called in this Reserve.
        typeHashes = _typeHashes;
    }

    // MANAGEMENT FUNCTIONS HERE

    // TODO: enableAsset
    // Enables the ability to deposit the asset into the pool so that it can be used for a strategy.
    // TODO: disableAsset
    // Prevents any new deposits being made with this asset from a user.

    // LENDING FUNCTIONS HERE

    // TODO: availableLiquidity()
    // Returns the amount of liquidity that is available to be used for strategy interaction.

    // TODO: totalConsumed()
    // Returns the amount of liquidity that is currently being used for strategy interaction.

    // TODO: totalUnderlying()
    // Returns the total amount of underlying that is currently in the pool.
    // (totalConsumed() + availableLiquidity())

    // BALANCE ACCOUNTING LOGIC HERE

    // TODO: internalBalances mapping
    // This is a mapping of the balances of the underlying assets that are in the pool to a specific user.

    // TODO: totalInternalbalances mapping
    // This is a mapping of the total balances of the underlying assets that are in the pool.

    // TODO: balanceOf()
    // Returns the balance of the underlying asset that is in the pool for a specific user.

    // TODO: internalBalanceExchangeRate()
    // Returns the exchange rate of the internal balances of the underlying asset that is in the pool.

    // CONSUMPTION ACCOUNTING LOGIC HERE

    // TODO: internalConsumption mapping
    // This is a mapping of the consumption of the underlying assets that are in the pool to a specific user.
    // Because the manager will always be the same (or maybe even the contract itself) this should probably
    // be abstracted to a single caller?

    // TODO: totalInternalConsumption mapping
    // This is a mapping of the total consumption of the underlying assets that are in the pool.

    // TODO: consumptionBalance()
    // Returns the consumption of the underlying asset that is in the pool for a specific user.

    // TODO: internalConsumptionExchangeRate()
    // Returns the exchange rate of the internal consumption of the underlying asset that is in the pool.

    // INTEREST
    // Think a reserve would be strongest without attempting to creating interest (yield) 
    // and instead just allowing the active strategy to create yield. This would be the
    // simplest way to do it. The reserve would just be a way to store the assets and
    // allow the strategy to consume them.

    // CONSUMPTION ALLOWANCE CHECKS
    // I don't think anything would be needed here.

    // COPY TRADER FUNCTIONS HERE

    // TODO: Deposit (copy trader)
    // TODO: Withdraw (copy trader)
}