module rethinkdb;

import std.socket, std.string, std.conv, std.stdio;

class Rethinkdb {

	struct Connection {
		Socket sock;
	}

	int nextToken = 1;
	
	public Connection connect(string host = "localhost", ushort port = 28015, string db = "" , string auth_key = "", int timeout = 20) {
		Connection c;
		c.sock = new Socket(AddressFamily.INET, SocketType.STREAM);
		c.sock.setOption(SocketOptionLevel.SOCKET, SocketOption.RCVTIMEO, dur!"seconds"(timeout));
		scope (exit) c.sock.close();
		c.sock.connect(new InternetAddress(host,port));
		c.sock.send("\x20\x2d\x0c\x40\x00\x00\x00\x00\xc7\x70\x69\x7e");
		char[1024] buf;
		auto rcv = c.sock.receive(buf);
		writefln("server said %d bytes: %s",rcv,buf[0..rcv]);
		return c;
	}

}

