import java.io.*;
import java.net.*;
import java.util.*;

/*
 * Client to send ping requests over UDP.
 */
public class PingClient {

    public static void main(String[] args) throws Exception {
        // Get command line argument
        if (args.length != 2) {
            System.out.println("Required arguments: host port");
            return;
        }

        String host = args[0];
        int port = Integer.parseInt(args[1]);

        InetAddress address = InetAddress.getByName(host);

        // Create a datagram socket for receiving and sending UDP packets
        // through the port specified on the command line.
        DatagramSocket socket = new DatagramSocket();

        for (int pingNumber = 0; pingNumber < 10; pingNumber++) {
            Date now = new Date();
            String message = "PING " + pingNumber + " " + now + "\r\n";
            byte[] txBuf = message.getBytes();

            // Create a datagram packet destined for the server
            DatagramPacket packet = new DatagramPacket(txBuf, txBuf.length, address, port);
            socket.send(packet);

            byte[] rxBuf = new byte[256];
            packet = new DatagramPacket(rxBuf, rxBuf.length);
            socket.setSoTimeout(1000);

            boolean continueWaiting = true;
            while (continueWaiting) {
                try {
                    socket.receive(packet);
                    String receivedMessage = new String(packet.getData());
                    if (message.trim().equals(receivedMessage.trim())) {
                        System.out.println("Received correct response to ping " + pingNumber);
                        continueWaiting = false;
                    } else {
                        System.out.println("Received unexpected response to ping " + pingNumber + ": " + receivedMessage.trim());
                    }
                } catch (SocketTimeoutException ste) {
                    System.out.println("Timeout while waiting for response to ping " + pingNumber);
                    continueWaiting = false;
                } catch (Exception e) {
                    System.err.println("Error while waiting for UDP reply: " + e);
                    continueWaiting = false;
                }
            }
        }

        socket.close();
    }
}