import sys.io.File;

class Main {
	static function main() 
	{
		// four 32-bit ints, xysb
        // s is the slot number 
        // s=0 for base object
        // s=1 decay ETA seconds (wall clock time)
        // s=2 for count of contained objects
        // s=3 first contained object
        // s=4 second contained object
        // s=... remaining contained objects
        // Then decay ETA for each slot, in order,
        //   after that.
        // s = -1
        //  is a special flag slot set to 0 if NONE
        //  of the contained items have ETA decay
        //  or 1 if some of the contained items might 
        //  have ETA decay.
        //  (this saves us from having to check each
    	//   one)
        // If a contained object id is negative,
        // that indicates that it sub-contains
        // other objects in its corresponding b slot
        //
        // b is for indexing sub-container slots
        // b=0 is the main object 
        // b=1 is the first sub-slot, etc.
		// one int, object ID at x,y in slot (s-3)
		// OR contained count if s=2
		var db = new KissDB("map.db",8000,16,4);
	}
}
