pragma solidity^0.4.11;
import "./StructFunds.sol";

library LibFunds
{
    struct Funds
    {
        StructFunds.value       data;
    }


    function insert(Funds storage self, uint qty)  internal 
    {
        self.data.total_funds_      +=      qty;
        self.data.ava_funds_         +=      qty;
    }


    function reduce(Funds storage self, uint qty) internal returns (bool)
    {
        if(self.data.ava_funds_ < qty)
            return false;

        self.data.total_funds_      -=      qty;
        self.data.frozen_funds_      -=      qty;
        return true;
    }

    function freeze(Funds storage self, uint qty) internal returns (bool)
    {
        if(self.data.ava_funds_ < qty)
            return false;

        self.data.ava_funds_        -=   qty;
        self.data.frozen_funds_     +=   qty;
        return true;
    }

    function getTotalFunds(Funds storage self) internal returns (uint)
    {
        return self.data.total_funds_;
    }


    function getAvaFunds(Funds storage self) internal returns (uint)
    {
        return self.data.ava_funds_;
    }

    function getFrozenFunds(Funds storage self) internal returns (uint)
    {
        return self.data.frozen_funds_;
    }

}



