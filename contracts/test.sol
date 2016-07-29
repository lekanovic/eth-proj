import "strings.sol";
import "sorter.sol";

contract Test {
    using strings for *;
    string public s1;
    
    event print(string);
    event print_b(byte);
    event print_int(uint);
    event print_b32(bytes32);
    uint[] lotto_number;
    
    function test(string str)
    {
        var s = str.toSlice();
        var delim = " ".toSlice();
        var len = s.count(delim) + 1;
        for(uint i = 0; i < len; i++) {
            lotto_number.push(parseInt(s.split(delim).toString()));
        }
        
        Sorter sort = Sorter(0xe0dccf67776caf8801dd1ac3ce5969111d74c6e0);
        sort.set(lotto_number);
        sort.sort();

        for (uint j=0;j<lotto_number.length;j++){
            lotto_number[j] = sort.data(j);
        }

        bytes32 hash = sha3(lotto_number);
        print_b32(hash);
    }
    function apa()
    {
        test("12 3 4 17 33 1");
    }
    // parseInt
    function parseInt(string _a) internal returns (uint) {
        return parseInt(_a, 0);
    }

    // parseInt(parseFloat*10^_b)
    function parseInt(string _a, uint _b) internal returns (uint) {
        bytes memory bresult = bytes(_a);
        uint mint = 0;
        bool decimals = false;
        for (uint i=0; i<bresult.length; i++){
            if ((bresult[i] >= 48)&&(bresult[i] <= 57)){
                if (decimals){
                   if (_b == 0) break;
                    else _b--;
                }
                mint *= 10;
                mint += uint(bresult[i]) - 48;
            } else if (bresult[i] == 46) decimals = true;
        }
        if (_b > 0) mint *= 10**_b;
        return mint;
    }
}