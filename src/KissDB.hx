import haxe.io.Encoding;
import sys.io.FileSeek;
import sys.FileSystem;
import haxe.io.Bytes;
import sys.io.File;
import sys.io.FileInput;
import sys.io.FileOutput;
class KissDB
{
    //errors
    private static inline var KISSDB_ERROR_IO = 0;
    private static inline var KISSDB_ERROR_MALLOC = 1;
    private static inline var KISSDB_ERROR_INVALID_PARAMETERS = 2;
    private static inline var KISSDB_ERROR_CORRUPT_DBFILE = 3;
    //constants
    private static inline var HEADER_SIZE = 28;
    //open
    var input:FileInput;
    var output:FileOutput;
    public function new(path:String,hash_table_size:Int,key_size:Int,value_size:Int)
    {
        if (!FileSystem.exists(path) && !FileSystem.isDirectory(path))
        {
            error(KISSDB_ERROR_IO);
            return;
        }
        output = File.update(path);
        input = File.read(path);
        //output.bigEndian = false;
        input.bigEndian = false;
        
        var header = Bytes.alloc(HEADER_SIZE);
        if (input.readBytes(header,0,header.length) < HEADER_SIZE)
        {
            //create header
            output.writeBytes(Bytes.ofString("Ld2"),0,3);
            trace("create header");
        }
        //read header
        trace("magic " + header.getString(0,3,RawNative));
        header = null;
        output.close();
    }
    public function close(database:KissDB)
    {
        input.close();
        if (output != null) output.close();
    }
    private function error(int:Int)
    {
        switch (int)
        {
            case KISSDB_ERROR_IO: trace('IO error $int');
            case KISSDB_ERROR_MALLOC: trace('Mallocation $int');
            case KISSDB_ERROR_INVALID_PARAMETERS: trace('Invalid parameters $int');
            case KISSDB_ERROR_CORRUPT_DBFILE: trace('Corrupt file $int');
        }
    }
}