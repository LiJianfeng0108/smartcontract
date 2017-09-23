pragma solidity ^0.4.5;
import "./LibString.sol";
import "./LibArray.sol";
import "./StructUserAddr.sol";
library LibUserAddrMap
{
    using LibString for *;
    struct UserAddrMap
    {
        mapping(bytes32 => StructUserAddr.value) data;
        bytes32[] keyIndex;
    }

    function insert(UserAddrMap storage self, bytes32 k, StructUserAddr.value v)  internal returns (bool replaced)
    {
        replaced = true;
        if(self.data[k].user_auth_ == 0)
        {
            self.keyIndex.push(k);
            replaced = false;
        }
        self.data[k] = v;
    }
    function remove(UserAddrMap storage self, bytes32 k) internal returns (bool existed)
    {
        if(self.data[k].user_auth_ == 0)
        {
            return false;
        }
        else
        {
            delete self.data[k];
            LibArray.deleteElement(self.keyIndex, k);
            return true;
        }
    }
    function getValue(UserAddrMap storage self, bytes32 k) internal returns (StructUserAddr.value)
    {
        return self.data[k];
    }
    /*
    function isExisted(UserAddrMap storage self, bytes32 k) internal returns (bool existed)
    {
        var (ret, ) = LibString.inArray(k, self.keyIndex);
        return ret;
    }
    */
    function empty(UserAddrMap storage self) internal returns (bool)
    {
        return (self.keyIndex.length == 0);
    }
    function it_start(UserAddrMap storage self) internal returns (uint)
    {
        if(empty(self))
                return uint(-1);
        return 0;
    }
    function it_next(UserAddrMap storage self, uint it) internal returns (uint)
    {
        it++;
        if(it < self.keyIndex.length)
            return it;
        else
            return uint(-1);
    }

    function it_valid(uint it) internal returns (bool)
    {
        if( (uint(-1) != it) )
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    function it_valid(UserAddrMap storage, uint it) internal returns (bool)
    {
        if( (uint(-1) != it) )
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    function getValue(UserAddrMap storage self, uint it) internal returns (StructUserAddr.value)
    {
        if(it + 1 > self.keyIndex.length)
        {
            StructUserAddr.value empty_value;
            return empty_value;
        }
        return self.data[ self.keyIndex[it] ];
    }
    function getKey(UserAddrMap storage self, uint it) internal returns (bytes32)
    {
        return self.keyIndex[it];
    }
    function size(UserAddrMap storage self) internal returns(uint)
    {
        return self.keyIndex.length;
    }
    function length(UserAddrMap storage self) internal returns(uint)
    {
        return self.keyIndex.length;
    }
}
