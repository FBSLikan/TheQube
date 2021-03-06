/** 
	TheQube Credentials
	Version 0.1

	This command-line utility takes a key, a secret and (optionally) an output file name and outputs TheQube credentials as a string ready to be stored in the app config.

	Copyright 2016, Andre Polykanine A.K.A. Menelion Elensúlë
	https://github.com/Oire
*/

module theqube.tools.credentials;

import std.stdio;
import std.file;
import std.base64;
import std.json;

int main(string[] args) {
	if (args.length < 3 || args.length > 4) {
		writeln("Usage: creds <key> <secret> [<outputFileName>]");
		return 1;
	}
	JSONValue data = [args[1], args[2]];
	string mCreds = data.toPrettyString();
	alias Base64Oire = Base64Impl!('-', '_', '~');
	string creds = Base64Oire.encode(cast(ubyte[])mCreds);
	if (args.length == 4) {
		auto f = File(args[3], "w");
		scope(exit) f.close();
		try {
			f.writeln(creds);
		} catch (Exception e) {
			writefln("Unable to write to %s: %s", args[3], e.msg);
			return 1;
		}
	} else { // The file is not provided
		writeln(creds);
	}
	return 0;
}