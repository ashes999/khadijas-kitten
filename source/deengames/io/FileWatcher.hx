package deengames.io;

import sys.FileSystem;
import sys.io.File;
import haxe.crypto.Sha1;

/** Watch a file. Use onWatch(...) to register a callback when the file changes. */
class FileWatcher {

  private var fileName:String;
  private var callback:Void->Void;

  public function new() {
    #if !neko
      throw "FileWatcher only works in Neko, sorry."
    #end
  }

  public function watch(fileName:String)
  {
    this.fileName = fileName;

    var t = neko.vm.Thread.create(function() {

      // The file is small, and file.mtime is not reliable on Linux with Dropbox
      var previousMtime = FileSystem.stat(fileName).mtime.getTime();

      while (true) {
        Sys.sleep(1); // 1s
        var mtime = FileSystem.stat(fileName).mtime.getTime();
        if (previousMtime != mtime) {
          previousMtime = mtime;
          trace("CHANGE!");
        }
      }
    });
    return this;
  }

  public function onChange(callback:Void -> Void) {
    this.callback = callback;
    return this;
  }
}
