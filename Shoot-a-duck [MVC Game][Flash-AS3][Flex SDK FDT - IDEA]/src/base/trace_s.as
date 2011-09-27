package  base{
	import flash.net.XMLSocket;
	public function trace_s(msgToSocket : String = 'test', msgType : String = 'debug') : void {
		try {
			var socket:XMLSocket = new XMLSocket;
			socket.connect("localhost", 4444);
			socket.send("!SOS<showMessage key='" + msgType + "'>" + msgToSocket + "</showMessage>\n");
		} catch (error : SecurityError) {
			trace_s("SecurityError in SOSAppender: " + error);
		}
	}
}
