import java.io.*;
import java.net.*;
import java.util.*;

/*
 * Client to send ping requests over UDP.
 */
public class PingClient {

	public static void main(String[] args) throws Exception {
		// Get host and port
		if (args.length != 2) {
			System.out.println("You forgot either a host or port. Example localhost 8000.");
			return;
		}

		// host is first in arg array.
		String host = args[0];
		// port is second in arg array.
		int port = Integer.parseInt(args[1]);

		// internet address is host in arg.
		InetAddress address = InetAddress.getByName(host);

		// create socket to listen on.
		DatagramSocket socket = new DatagramSocket();

		// creates ten ping messages
		for (int pingNum = 0; pingNum < 10; pingNum++) {
			Date timeStamp = new Date();
			String datamessage = "PING " + pingNum + " " + timeStamp + "\r\n";
			byte[] txBuf = datamessage.getBytes();

			// Sends datapacket
			DatagramPacket dataPacket = new DatagramPacket(txBuf, txBuf.length, address, port);
			socket.send(dataPacket);
			byte[] rxBuf = new byte[256];
			dataPacket = new DatagramPacket(rxBuf, rxBuf.length);

			// socket time out is 1 second.
			socket.setSoTimeout(1000);

			boolean wait = true;
			while (wait) {
				try {
					socket.receive(dataPacket);
					String receivedMessage = new String(dataPacket.getData());

					// If data received is same as sent then move to next packet.
					if (datamessage.trim().equals(receivedMessage.trim())) {
						System.out.println("Received correct response to ping  " + pingNum);
						wait = false;
					} else {
						System.out.println("Data not a duplicate as original ping " + pingNum + ", received message "
								+ receivedMessage.trim());
					}
				} catch (SocketTimeoutException ste) {
					System.out.println("Socket timed out on ping " + pingNum);
					wait = false;
				} catch (Exception e) {
					System.err.println("Error on reply of packet " + e);
					wait = false;
				}
			}
		}

		socket.close();
	}
}