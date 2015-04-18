module rethinkdb;

import std.socket, std.string, std.conv, std.stream, std.socketstream, std.stdio;

struct Rethinkdb {

	string rethinkdb_host;
	ushort rethinkdb_port;
	Stream rethinkdb_connection;
	
	public void connect(string domain, ushort port) {
		Socket rdb = new TcpSocket(new InternetAddress(domain,port));
		scope (exit) rdb.close();
		rethinkdb_connection = new SocketStream(rdb);
	}
}

